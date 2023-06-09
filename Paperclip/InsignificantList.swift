//
//  InsignificantList.swift
//  Paperclip
//
//  Created by Luke Drushell on 3/18/23.
//

import SwiftUI

struct InsignificantList: View {
    
    @Binding var notes: [Note]
    @Binding var search: String
    
    var body: some View {
        if !notes.insignificant().getContaining(search).isEmpty {
            HStack {
                Text("Insignificant:")
                    .foregroundColor(.gray)
                    .padding(.leading)
                Spacer()
            }
            ForEach($notes) { $note in
                if note.noteContains(search) && (note.importance == .insignficant) {
                    NavigationLink(destination: {
                        NoteEditor(note: note)
                            .onDisappear(perform: {
                                notes = loadNotes()
                            })
                    }, label: {
                        HStack {
                            Image(systemName: note.icon)
                                .foregroundColor(.accentColor)
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
                        .shadow(color: .black.opacity(0.085), radius: 4, x: 1, y: 3)
                }
            }
        }
    }
}

struct InsignificantList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
