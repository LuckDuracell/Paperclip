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
            ForEach(notes.insignificant()) { note in
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
        }
    }
}

struct InsignificantList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
