//
//  MemoryGame.swift
//  CS193p
//
//  Created by apple on 2023/1/20.
//

import Foundation


struct MemoryGame<CardContent>{
    
    private(set) var cards : Array<Card>
    
    mutating func choose(_ card:Card){
        let chosenCard = Index(of: card)
        cards[chosenCard].isFaceUp.toggle()
    }
    
    
    func Index(of card : Card) ->Int{
        for index in 0..<cards.count{
            if cards[index].id == card.id{
                return index
            }
        }
        return 0
    }
    
    init(numberOfPairsOfCards:Int , createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id:pairIndex * 2))
            cards.append(Card(content: content, id:pairIndex * 2 + 1))
        }
    }
    
    struct Card:Identifiable{
        var isFaceUp:Bool = true
        var isMatched:Bool = true
        var content:CardContent
        var id:Int
        
        
    }
    
    
}
