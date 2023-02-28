//
//  MemoryGame.swift
//  CS193p
//
//  Created by apple on 2023/1/20.
//

import Foundation

// This is Model
struct MemoryGame<CardContent> where CardContent: Equatable{
    
    private(set) var cards : Array<Card>
    private var IndexOfTheOneAndOnlyFaceUpCard : Int?
    
    mutating func choose(_ card:Card){
        
        if let chosenCard = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenCard].isFaceUp,
            !cards[chosenCard].isMatched
        {
            if let PotentialChoseCardIndex = IndexOfTheOneAndOnlyFaceUpCard{
                if cards[chosenCard].content == cards[PotentialChoseCardIndex].content {
                        cards[chosenCard].isMatched = true
                        cards[PotentialChoseCardIndex].isMatched = true
                    }
                IndexOfTheOneAndOnlyFaceUpCard = nil
                }
                else{
                    for index in cards.indices{
                        cards[index].isFaceUp = false
                    }
                    IndexOfTheOneAndOnlyFaceUpCard = chosenCard
                }
            cards[chosenCard].isFaceUp.toggle()
        }
    }
    
    
    
    func Index(of card : Card) ->Int?{
        for index in 0..<cards.count{
            if cards[index].id == card.id{
                return index
            }
        }
        return nil
    }
    
    init(numberOfPairsOfCards:Int , createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id:pairIndex * 2))
            cards.append(Card(content: content, id:pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable{
        var isFaceUp:Bool = false
        var isMatched:Bool = false
        var content:CardContent
        var id:Int
        
        
    }
}


struct Theme {
    
    let ThemeName : String?
    let NumberOfCards :Int
    let ThemeColor : String?
    let emojis : [String]
    
}
