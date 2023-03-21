//
//  BulletNote.swift
//  Paperclip
//
//  Created by Luke Drushell on 3/19/23.
//

import SwiftUI

struct BulletNote: View {
    
    @State var bulletNote: String
    
    var body: some View {
        HStack {
            Image(systemName: "largecircle.fill.circle")
                .font(.title)
            TextField("", text: $bulletNote, axis: .vertical)
                .scrollContentBackground(.hidden)
                .frame(minHeight: screen().height * 0.04, maxHeight: .infinity)
                .padding(5)
                .background(.regularMaterial)
                .font(.headline)
        } .padding()
    }
}

struct BulletNote_Previews: PreviewProvider {
    static var previews: some View {
        BulletNote(bulletNote: "Testing")
    }
}
