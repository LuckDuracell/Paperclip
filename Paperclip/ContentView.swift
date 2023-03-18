//
//  ContentView.swift
//  Paperclip
//
//  Created by Luke Drushell on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var notes: [Note] = [Note(importance: .important, title: "My first note is going to be awesome", words: "baihgaokgha"), Note(importance: .important, title: "Test 2", words: "baihgaokgha"), Note(importance: .insignficant, title: "Test 3", words: "baihgaokgha"), Note(importance: .important, title: "Test 4", words: "baihgaokgha"), Note(importance: .somewhat, title: "Test 5", words: "baihgaokgha"), Note(importance: .somewhat, title: "Test 6", words: "baihgaokgha")]
    
    @State var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primary.colorInvert()
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        ImportantList(notes: $notes, search: $searchText)
                        SomewhatList(notes: $notes, search: $searchText)
                        InsignificantList(notes: $notes, search: $searchText)
                    } .padding(.top)
                }
            } .navigationTitle("Paperclip 📎")
                .searchable(text: $searchText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct Note: Codable, Hashable, Identifiable {
    var importance: Importance
    var title: String
    var words: String
    var icon: String = "note.text"
    var lastEditDate: Date = Date()
    var firstCreatedDate: Date = Date()
    var passwordProtected: Bool = false
    var password: String = ""
    var id = UUID()
}

enum Importance: Codable {
    case insignficant
    case somewhat
    case important
}

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
