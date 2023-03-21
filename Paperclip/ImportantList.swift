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
                ForEach($notes) { $note in
                    if note.noteContains(search) && note.importance == .important {
                        NavigationLink(destination: {
                            NoteEditor(note: note)
                                .onDisappear(perform: {
                                    notes = loadNotes()
                                })
                        }, label: {
                            VStack {
                                HStack {
                                    ZStack {
                                        Circle()
                                            .foregroundColor(.accentColor)
                                        Image(systemName: note.icon)
                                            .foregroundColor(.white)
                                            .padding(5)
                                    }
                                    Text(note.lastEditDate, style: .date)
                                    Spacer()
                                } .padding(.bottom, 1)
                                    .font(.footnote)
                                Text(note.title)
                                    .font(.system(.subheadline, weight: .medium))
                            }
                            .padding()
                            .frame(width: screen().width * 0.45, height: screen().width * 0.2)
                            .background(.regularMaterial)
                            .cornerRadius(15)
                            
                        }) .foregroundColor(.primary)
                            .shadow(color: .black.opacity(0.085), radius: 4, x: 1, y: 3)
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


