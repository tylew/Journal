//
//  SettingsView.swift
//  Journal
//
//  Created by Tyler Lewis on 5/15/24.
//

import SwiftUI

// App settings view
struct SettingsView: View {
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("userBio") private var userBio: String = ""
    @AppStorage("appearanceMode") private var appearanceMode: String = AppearanceMode.system.rawValue
//    Programatic focus of bio field, because real textField is too small
    @FocusState private var bioFieldFocused: Bool
    let characterLimit = 100

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Profile")) {
                        TextField("Name", text: $userName)
                        
                        HStack(alignment: .top  ) {
                            TextField("Create a bio", text: $userBio, axis: .vertical)
                                .focused($bioFieldFocused)
                                .onChange(of: userBio) { newValue in
                                    // Remove new lines
                                    let filteredText = newValue.replacingOccurrences(of: "\n", with: "")
                                    
                                    // Enforce character limit
                                    if filteredText.count > characterLimit {
                                        userBio = String(filteredText.prefix(characterLimit))
                                    } else {
                                        userBio = filteredText
                                    }
                                }
                            Spacer().frame(height: 100)
                        }
                            .background(Color.white)
                            .onTapGesture {
                            // Trigger focus when the HStack is tapped
                            self.bioFieldFocused = true
                        }                }
//                    Section() {
//                        
//                        VStack (alignment: .leading) {
//                            Text("App lightness")
//                            Picker("Mode", selection: $appearanceMode) {
//                                ForEach(AppearanceMode.allCases, id: \.self) { mode in
//                                    Text(mode.rawValue).tag(mode.rawValue)
//                                }
//                            }
//                            .pickerStyle(SegmentedPickerStyle())
//                        }
//                    }
                }
                .navigationTitle("App Settings")
            .navigationBarTitleDisplayMode(.inline)
//                Spacer()
                Text("Tyler Lewis ©2024").font(.footnote)
            }
        }
    }
    
}

#Preview {
    SettingsView()
}
