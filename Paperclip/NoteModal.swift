//
//  NoteModal.swift
//  Paperclip
//
//  Created by Luke Drushell on 3/18/23.
//

import Foundation
import SwiftUI


struct Note: Codable, Hashable, Identifiable {
    var importance: Importance
    var title: String
    var words: String
    var icon: String = "note.text"
    var lastEditDate: Date = Date()
    var firstCreatedDate: Date = Date()
    var passwordProtected: Bool = false
    var password: String = ""
    var contentType: ContentType = .words
    var id = UUID()
}

enum Importance: Codable {
    case insignficant
    case somewhat
    case important
}

enum ContentType: Codable {
    case words
    case bullets
    case checklist
    case drawing
    case image
    case video
    case bold
    case title
    case caption
}

// When combined with the updateNote function, this allows for live updating of UserDefaults without reloading the current Note in view
func saveNotes(_ notes: [Note]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(notes) {
        UserDefaults.standard.set(encoded, forKey: "notes")
    }
}

// Retrieve the array of StickyNotes from UserDefaults
func loadNotes() -> [Note] {
    let decoder = JSONDecoder()
    if let data = UserDefaults.standard.object(forKey: "notes") as? Data,
       let notes = try? decoder.decode([Note].self, from: data) {
        return notes
    }
    return [Note(importance: .important, title: "This is your first note!", words: "You can add more notes by clicking the plus in the top right!")]
}

extension [Note] {
    func important() -> [Note] {
        var output: [Note] = []
        for note in self {
            if note.importance == .important { output.append(note) }
        }
        return output
    }
    func somewhat() -> [Note] {
        var output: [Note] = []
        for note in self {
            if note.importance == .somewhat { output.append(note) }
        }
        return output
    }
    func insignificant() -> [Note] {
        var output: [Note] = []
        for note in self {
            if note.importance == .insignficant { output.append(note) }
        }
        return output
    }
    func getContaining(_ search: String) -> [Note] {
        if search == "" || search == " " { return self }
        var output: [Note] = []
        for note in self {
            if note.title.contains(search) { output.append(note) } else if note.words.contains(search) { output.append(note) }
        }
        return output
    }
}

extension Note {
    func noteContains(_ search: String) -> Bool {
        if search == "" || search == " " { return true }
        if self.title.contains(search) { return true }
        if self.words.contains(search) { return true }
        return false
    }
}


func updatedNote(_ note: Note) -> [Note] {
    var notes = loadNotes()
    for i in notes.indices {
        if notes[i].id == note.id { notes[i] = note }
    }
    return notes
}
