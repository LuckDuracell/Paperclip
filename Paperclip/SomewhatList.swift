//
//  SomewhatList.swift
//  Paperclip
//
//  Created by Luke Drushell on 3/18/23.
//

import SwiftUI

struct SomewhatList: View {
    
    @Binding var notes: [Note]
    @Binding var search: String
    
    var body: some View {
        if !notes.somewhat().getContaining(search).isEmpty {
            HStack {
                Text("Somewhat:")
                    .foregroundColor(.gray)
                    .padding(.leading)
                Spacer()
            }
            ForEach(notes.somewhat()) { note in
                if note.noteContains(search) {
                    NavigationLink(destination: {
                        
                    }, label: {
                        HStack {
                            Image(systemName: note.icon)
                            Text(note.title)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.title3)
                                .foregroundColor(.gray)
                        }
                        .font(.title3)
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    }) .foregroundColor(.primary)
                }
            }
            Divider()
                .padding()
        }

    }
}

struct SomewhatList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
