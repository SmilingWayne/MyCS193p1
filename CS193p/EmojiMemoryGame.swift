//
//  EmojiMemoryGame.swift
//  CS193p
//
//  Created by apple on 2023/1/20.
//

import Foundation

class EmojiMemoryGame: ObservableObject{
    static let emojis = ["🐶","🐱","🐭","🐍","🦁️","🐺","🐷","🐸","🐑","🦕","🐘","🦛","🐆","🐯"]
    static func createMemoryGame() -> MemoryGame<String>{
        MemoryGame<String>(numberOfPairsOfCards: 3, createCardContent: {
            pairIndex in
            emojis[pairIndex]
        })
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
