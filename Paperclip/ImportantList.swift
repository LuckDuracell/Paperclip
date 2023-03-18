//
//  ImportantList.swift
//  Paperclip
//
//  Created by Luke Drushell on 3/18/23.
//

import SwiftUI

struct ImportantList: View {
    
    @Binding var notes: [Note]
    @Binding var search: String
    
    var body: some View {
        if !notes.important().getContaining(search).isEmpty {
            HStack {
                Text("Important:")
                    .foregroundColor(.gray)
                    .padding(.leading)
                Spacer()
            }
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(notes.important()) { note in
                    if note.noteContains(search) {
                        NavigationLink(destination: {
                            NoteEditor(note: note)
                        }, label: {
                            VStack {
                                HStack {
                                    Image(systemName: note.icon)
                                    Text(note.lastEditDate, style: .date)
                                    Spacer()
                                } .padding(.bottom, 1)
                                    .font(.footnote)
                                Text(note.title)
                            }
                            .padding()
                            .frame(width: screen().width * 0.45, height: screen().width * 0.2)
                            .background(.regularMaterial)
                            .cornerRadius(15)
                        }) .foregroundColor(.primary)
                    }
                }
            } .padding(.horizontal)
            Divider()
                .padding()
        }
    }
}

struct ImportantList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

