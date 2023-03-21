//
//  NoteEditor.swift
//  Paperclip
//
//  Created by Luke Drushell on 3/18/23.
//

import SwiftUI

struct NoteEditor: View {
    
    @State var note: Note
    
    @FocusState var showKeyboard: Bool
    
    var body: some View {
        VStack {
            TextField("Title", text: $note.title)
                .foregroundColor(.primary)
                .font(.largeTitle.bold())
                .padding(.horizontal)
                .focused($showKeyboard)
            ScrollView {
                if note.contentType == .words {
                    TextEditor(text: $note.words)
                        .padding()
                        .frame(minWidth: screen().width, minHeight: screen().height * 0.07, maxHeight: .infinity)
                        .scrollContentBackground(.visible)
                        .background(.blue)
                        .focused($showKeyboard)
                } else if note.contentType == .bullets {
                    ForEach(note.words.split(separator: ";"), id: \.self) { bulletNote in
                        BulletNote(bulletNote: String(bulletNote))
                            .onSubmit {
                                withAnimation {
                                    //there is a zero width character after this semicolon (used to tell split to include an index after the final semicolon)
                                    var split = note.words.split(separator: ";")
                                    split[split.count - 1] = bulletNote
                                    note.words = split.joined(separator: ";")
                                    note.words.append(";​")
                                }
                            }
                    }
                    Text(note.words)
                        .background(.green)
                        .padding(.top)
                }
            }
            .scrollDismissesKeyboard(.interactively)
        } .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .keyboard, content: {
                    HStack(spacing: 10) {
                        Button {
                            note.contentType = .words
                        } label: {
                            Image(systemName: "textformat")
                        }
                        Button {
                            note.contentType = .bullets
                        } label: {
                            Image(systemName: "checklist")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "pencil.tip.crop.circle")
                        }
                    }
                })
            })
            .onChange(of: note, perform: { _ in
                saveNotes(updatedNote(note))
            })
            .onAppear(perform: {
                // just updates the string on load, this allows the texteditor to fit itself to whatever words are currently there
                DispatchQueue.main.async {
                    note.words += " "
                    note.words = String(note.words.dropLast(1))
                }
            })
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NoteEditor(note: Note(importance: .somewhat, title: "Title", words: "words are pretty cool; wowow two?", contentType: .bullets))
        }
    }
}

extension [Substring] {
    func unsplit(seperator: Character) -> String {
        var output = ""
        for i in self {
            output += i
        }
        return output
    }
}
