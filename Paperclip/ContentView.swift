//
//  ContentView.swift
//  Paperclip
//
//  Created by Luke Drushell on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var notes: [Note] = loadNotes()
    
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
