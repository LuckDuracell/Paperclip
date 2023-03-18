//
//  NoteEditor.swift
//  Paperclip
//
//  Created by Luke Drushell on 3/18/23.
//

import SwiftUI

struct NoteEditor: View {
    
    @State var note: Note
    
    @FocusState var showTitleKeyboard: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            TextField("", text: $note.title)
                .foregroundColor(.blue)
                .focused($showTitleKeyboard)
            NavigationStack {
                ScrollView {
                    TextEditor(text: $note.words)
                        .padding()
                        .frame(width: screen().width, height: screen().height)
                        .scrollContentBackground(.hidden)
                        .background(.blue.opacity(0.5))
                } .navigationTitle(note.title)
            }
            Button {
                showTitleKeyboard = true
            } label: {
                Rectangle()
                    .frame(height: 60)
                    .foregroundColor(.green.opacity(showTitleKeyboard ? 0.9 : 0.325))
                    .padding(.top, 30)
            }
        }
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditor(note: Note(importance: .somewhat, title: "Title", words: "hello there!"))
    }
}
