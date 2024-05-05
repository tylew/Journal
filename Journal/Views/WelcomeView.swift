//
//  SwiftUIView.swift
//  Journal
//
//  Created by Tyler Lewis on 5/2/24.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
            Spacer()
            Image("boy-at-desk").resizable()
                .frame(width: 210, height: 200).cornerRadius(27) // Inner corner radius
                .padding(2) // Width of the border
                .background(.black) // Color of the border
                .cornerRadius(30)
//            Rectangle()
//                .fill(.gray) // Use the custom color
//                            .frame(width: 200, height: 200) // Specify the size of the rectangle
//                            .cornerRadius(10) // Optional: round the corners
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Continue —>")
                    .foregroundColor(.white)  // Using the custom color
                    .padding()
                    .background(Color.appPurple)  // Example of background usage
                    .cornerRadius(10)
            })
            
        })
    }
}

#Preview {
    Welcome()
}
