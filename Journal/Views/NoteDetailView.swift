//
//  NoteDetail.swift
//  Journal
//
//  Created by Tyler Lewis on 5/9/24.
//

import SwiftUI
import CoreData
import Photos

class FocusManager: ObservableObject {
    @Published var isTextFieldFocused: Bool = false
}

struct CDNoteDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var note: CDNote
    @FocusState private var isFocused: Bool
    @State private var showImagePicker = false
    @State private var imageData: Data?
    
    init(note: CDNote) {
        self.note = note
//        _title = State(initialValue: note.title)
    }

    var body: some View {
        VStack(spacing: 0) {
            TextField("Enter title", text: $note.title)
                .focused($isFocused, equals: true)
                .font(.largeTitle.bold())
                .foregroundColor(Color.appPurple)
                .padding(.horizontal)
                .padding(.top)
            
            Divider().frame(minHeight: 2).overlay(Color.appPurple.opacity(0.5)).padding(.horizontal, 10).padding(.top, 5)
            
            // List of content blocks using the directly available array
            
            List {
                ForEach(note.contentBlocks, id: \.self) { contentBlock in
                    if let textBlock = contentBlock as? CDTextBlock {
                        HStack {
                            VStack(alignment: .leading) {
                                TextField("Start typing", text: Binding(
                                    get: { textBlock.text },
                                    set: { textBlock.text = $0 }
                                ), axis: .vertical)
                                .focused($isFocused, equals: true)
                                .padding(.vertical, 1)
                                .foregroundColor(.black)
                                Text("\(contentBlock.creationDate, formatter: NoteRow.dateFormatter)").foregroundColor(.gray).font(.system(size: 13))
                            }
                            Spacer()
                        }
                    } else if let imageBlock = contentBlock as? CDImageBlock {
                        if let imageData = imageBlock.imageData_, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 300)
                                .padding(.vertical)
                        }
                    }
                }
                .onDelete(perform: deleteContentBlock)
            }
            .listStyle(PlainListStyle())
            
            Divider().frame(minHeight: 1).overlay(Color.appPurple.opacity(0.5))
            
            NoteDetailMenu(
                addImageBlock: showImagePickerFunc,
                addTextBlock: addTextBlock,
                releaseFocus: releaseFocus
            ).padding(.horizontal, 20).padding(.vertical, 5)
            // Button to add a new content block
//            Button("Add Content Block") {
//                addTextBlock()
//            }
            
        }
//        .navigationBarItems(trailing: EditButton())
        .navigationBarTitle("", displayMode: .inline)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(imageData: $imageData, onImagePicked: addImageBlock).ignoresSafeArea()
        }
//        .navigationBarHidden(true)
    }
    
//    private func saveTitle() {
//        note.title = title
//        
//        do {
//            try viewContext.save()
//        } catch {
//            print("Failed to save title: \(error)")
//        }
//    }
    private func releaseFocus() {
        isFocused = false
    }

    // Delete a content block
    private func deleteContentBlock(at offset: IndexSet) {
        note.removeContentBlocks(at: offset)

        // Save the context after deletion
        do {
            try viewContext.save()
        } catch {
            print("Failed to save after deletion: \(error)")
        }
    }
    
    private func showImagePickerFunc() {
        requestPhotoLibraryAccess {
            self.showImagePicker = true
        }
    }
    
    private func addImageBlock(uiImage: UIImage) {
        guard let imageData = uiImage.jpegData(compressionQuality: 1.0) else { return }
        print("add image blck")
        _ = CDImageBlock(context: viewContext, note: note, imagedata: imageData)
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save new image block: \(error)")
        }
    }

    // Add a new content block to the note
    private func addTextBlock() {
        _ = CDTextBlock(context: viewContext, note: note)

        // Save changes to persist the new block
        do {
            try viewContext.save()
        } catch {
            print("Failed to save new content block: \(error)")
        }
    }
    
    private func requestPhotoLibraryAccess(completion: @escaping () -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                if status == .authorized {
                    completion()
                } else {
                    print("Authorization to access photo library was denied.")
                }
            }
        }
    }
}


#if DEBUG

struct CDNoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Fetch the first note from the preview context
        let note = fetchFirstPreviewNote()

        // Create the CDNoteDetailView with the fetched note
        return CDNoteDetailView(note: note)
            .environment(\.managedObjectContext, PersistentController.preview.noteContainer.viewContext)
    }

    static func fetchFirstPreviewNote() -> CDNote {
        let fetchRequest: NSFetchRequest<CDNote> = CDNote.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CDNote.creationDate_, ascending: true)]
        
        do {
            let notes = try PersistentController.preview.noteContainer.viewContext.fetch(fetchRequest)
            if let firstNote = notes.first {
                return firstNote
            } else {
                fatalError("No notes available for preview.")
            }
        } catch {
            fatalError("Error fetching notes for preview: \(error)")
        }
    }
}
#endif
