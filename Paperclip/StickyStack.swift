//
//  StickyStack.swift
//  Paperclip
//
//  Created by Luke Drushell on 3/17/23.
//

import SwiftUI

struct StickyStack: View {
    
    let stickyStack = [0,0,0,0,0,]
    
    var body: some View {
        ForEach(stickyStack.indices, id: \.self, content: { i in
            Rectangle()
                .frame(width: screen().width * 0.7, height: screen().width * 0.75)
                .foregroundColor(Color("stickyYellow"))
                .overlay(alignment: .top, content: {
                    LinearGradient(colors: [Color("stickyYellowTop"), Color("stickyYellowTop"), Color("stickyYellow")], startPoint: .top, endPoint: .bottom)
                        .frame(height: 15)
                })
                .shadow(color: .black.opacity(0.02), radius: 7, x: 8, y: 8)
                .offset(x: CGFloat(-i), y: CGFloat(i * -2))
                .scaleEffect(0.35)
        })
    }
}

struct StickyStack_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
