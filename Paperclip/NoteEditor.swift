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
        VStack {
            TextField("Title", text: $note.title)
                .foregroundColor(.primary)
                .font(.largeTitle.bold())
                .padding(.horizontal)
                .focused($showTitleKeyboard)
            ScrollView {
                TextEditor(text: $note.words)
                    .padding()
                    .frame(minWidth: screen().width, minHeight: screen().height * 0.6 , maxHeight: .infinity)
                    .scrollContentBackground(.visible)
                    .scrollDisabled(true)
            }
        } .navigationBarTitleDisplayMode(.inline)
            .onChange(of: note, perform: { _ in
                saveNotes(updatedNote(note))
            })
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditor(note: Note(importance: .somewhat, title: "Title", words: "hello there!"))
    }
}

