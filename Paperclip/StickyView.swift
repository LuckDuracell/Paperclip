//
//  ContentView.swift
//  Paperclip
//
//  Created by Luke Drushell on 3/17/23.
//

import SwiftUI

struct StickyView: View {
    
    @State var stickies: [StickyNote] = loadStickyNotes()
    @FocusState var showKeyboard: Bool
    
    @State var moving = false
    
    func clearStickyZ() {
        for i in stickies.indices {
            stickies[i].zInd = 0
        }
    }
    
    func overTrash(_ pos: CGPoint) -> Bool {
        let trash = (x: screen().width * 0.87, y: screen().height * 0.89)
        if abs(pos.x - trash.x) < (screen().width * 0.12) && abs(pos.y - trash.y) < (screen().width * 0.16) {
            return true
        }
        return false
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("alice")
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showKeyboard = false
                    }
                StickyStack()
                    .position(x: screen().width * 0.17, y: screen().height * 0.07)
                    .onTapGesture {
                        stickies.append(StickyNote(words: "", position: CGPoint(x: screen().width * 0.5 + 140, y: screen().height * 0.3 + 148)))
                    }
                Text("🗑️")
                    .font(.system(size: 60))
                    .position(x: screen().width * 0.87, y: screen().height * 0.89)
                    .disabled(!moving)
                    .opacity(moving ? 1 : 0)
                ForEach($stickies, content: { $sticky in
                    TextEditor(text: $sticky.words)
                        .font(.system(.body, design: .rounded, weight: .light))
                        .scaleEffect(sticky.almostTrash ? 0.5 : 1)
                        .foregroundColor(.black)
                        .padding(.top, 25)
                        .padding(5)
                        .frame(width: 260, height: 270)
                        .scrollContentBackground(.hidden)
                        .background(
                            Color(sticky.almostTrash ? "stickyTrash" : "stickyYellow").shadow(color: .black.opacity(0.1), radius: 6, x: 5, y: 5)
                                .overlay(alignment: .top, content: {
                                    LinearGradient(colors: [Color("stickyYellowTop"), Color("stickyYellowTop"), Color("stickyYellow")], startPoint: .top, endPoint: .bottom)
                                        .frame(height: 20)
//                                    Color("stickyYellowTop")
//                                        .frame(height: 20)
                                })
                                .scaleEffect(sticky.almostTrash ? 0.5 : 1)
                        )
                        .rotationEffect(Angle(degrees: sticky.almostTrash ? 8 : 0), anchor: .center)
                        .position(sticky.position)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    DispatchQueue.main.async {
                                        clearStickyZ()
                                        sticky.zInd = 4
                                        withAnimation(.spring().speed(1.5)) {
                                            moving = true
                                            sticky.moving = true
                                            sticky.position.x = gesture.location.x
                                            sticky.position.y = gesture.location.y
                                        }
                                        if overTrash(gesture.location) {
                                            sticky.almostTrash = true
                                        }
                                        if !overTrash(gesture.location) {
                                            sticky.almostTrash = false
                                        }
                                    }
                                })
                                .onEnded({_ in
                                    withAnimation(.spring()) {
                                        sticky.moving = false
                                        moving = false
                                        if sticky.almostTrash {
                                            DispatchQueue.main.async {
                                                stickies.removeMatchingID(id: sticky.id)
                                            }
                                        }
                                    }
                                })
                        )
                        .scaleEffect(sticky.moving ? 0.9 : 0.85, anchor: .center)
                        .focused($showKeyboard)
                        .zIndex(sticky.zInd)
                        .animation(.spring(), value: showKeyboard)
                        .animation(.spring(), value: sticky.almostTrash)
                })
            }
        } .onChange(of: stickies, perform: { _ in
            saveStickyNotes(stickies)
        })
    }
}

struct StickyNote: Identifiable, Equatable, Codable {
    var words: String
    var position: CGPoint
    var moving: Bool = false
    var almostTrash = false
    var zInd: Double = 0
    let id = UUID()
}

struct screen {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
}

func saveStickyNotes(_ stickyNotes: [StickyNote]) {
    
    var savableStickies: [StickyNote] = []
    for i in stickyNotes {
        if i.words != "" {
            savableStickies.append(i)
        }
    }
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(savableStickies) {
        UserDefaults.standard.set(encoded, forKey: "stickies")
    }
}

// Retrieve the array of StickyNotes from UserDefaults
func loadStickyNotes() -> [StickyNote] {
    let decoder = JSONDecoder()
    if let data = UserDefaults.standard.object(forKey: "stickies") as? Data,
       let stickyNotes = try? decoder.decode([StickyNote].self, from: data) {
        return stickyNotes
    }
    return [StickyNote(words: "This is your first sticky!", position: CGPoint(x: 200, y: 300))]
}

extension [StickyNote] {
    mutating func removeMatchingID(id: UUID) {
        for i in self.indices {
            if self[i].id == id {
                self.remove(at: i)
                break
            }
        }
    }
}

struct StickyView_Previews: PreviewProvider {
    static var previews: some View {
        StickyView()
    }
}
