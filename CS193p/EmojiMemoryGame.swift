//
//  EmojiMemoryGame.swift
//  CS193p
//
//  Created by apple on 2023/1/20.
//

import SwiftUI

import Foundation

// This is ViewModel
class EmojiMemoryGame: ObservableObject{

    static private var vehicleEmojis = ["🚗", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛", "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶", "🛥", "🚞", "🚟", "🚃"]
    static private var animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐵"]
    static private var foodEmojis = ["🍔", "🥐", "🍕", "🥗", "🥟", "🍣", "🍪", "🍚", "🍝", "🥙", "🍭", "🍤", "🥞", "🍦", "🍛", "🍗"]
    static private var heartEmojis = ["❤️", "🧡", "💛", "💚", "💙", "💜"]
    static private var sportsEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏉", "🥏", "🏐", "🎱", "🏓", "🏸", "🏒", "🥊", "🚴‍♂️", "🏊", "🧗‍♀️", "🤺", "🏇", "🏋️‍♀️", "⛸", "⛷", "🏄", "🤼"]
    static private var weatherEmojis = ["☀️", "🌪", "☁️", "☔️", "❄️"]
    
    
    static private let colors = ["black", "gray", "red", "green", "blue", "orange",
        "yellow", "pink", "purple", "fushia", "beige", "gold"]
        
    static func getColor(_ chosenColor: String) -> Color {
        switch chosenColor {
        case "black":
            return .black
        case "gray":
            return .gray
        case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "pink":
            return .pink
        case "purple":
            return .purple
        default:
            return .red
        }
    }
    
    static func createTheme(_ name:String, _ emojis:[String], _ defaultNumber:Int) -> Theme {
        var NumberOfPairsOfCards = defaultNumber
        let color = colors.randomElement()
        
        if emojis.count < defaultNumber{
            NumberOfPairsOfCards = emojis.count
        }
        return Theme(ThemeName : name,  NumberOfCards: NumberOfPairsOfCards, ThemeColor : color, emojis: emojis.shuffled())
    }
    
    static var themes : [Theme] = {
        var themes = [Theme]()
        let defaultPairsOfCards = 8
       
        themes.append(createTheme("Vehicle", vehicleEmojis, defaultPairsOfCards))
        themes.append(createTheme("Animal", animalEmojis, defaultPairsOfCards))
        themes.append(createTheme("Food", foodEmojis, defaultPairsOfCards))
        themes.append(createTheme("Heart", heartEmojis, defaultPairsOfCards))
        themes.append(createTheme("Sports", sportsEmojis, defaultPairsOfCards))
        
        return themes
    }()
    
//    static func createTheme() ->
    static func createMemoryGame(of chosenTheme: Theme) -> MemoryGame<String> {
            var numberOfPairsOfCards = chosenTheme.NumberOfCards
            if chosenTheme.ThemeName == "Vehicles" || chosenTheme.ThemeName == "Animals" {
                numberOfPairsOfCards = Int.random(in: 2...chosenTheme.emojis.count)
            }
            return MemoryGame(numberOfPairsOfCards: numberOfPairsOfCards) { chosenTheme.emojis[$0] }
        }
    

    static func choseTheme() -> Theme {
        return EmojiMemoryGame.themes.randomElement()!
    }
    
    private(set) var chosenTheme: Theme
    private(set) var chosenColor: Color?
    @Published private var model: MemoryGame<String>
    
    
    init() {
        chosenTheme = EmojiMemoryGame.choseTheme()
        model = EmojiMemoryGame.createMemoryGame(of : chosenTheme)
        chosenColor = EmojiMemoryGame.getColor(chosenTheme.ThemeColor!)
    }
        
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    
    func startNewGame() {
        chosenTheme = EmojiMemoryGame.choseTheme()
        model = EmojiMemoryGame.createMemoryGame(of : chosenTheme)
        chosenColor = EmojiMemoryGame.getColor(chosenTheme.ThemeColor!)
        
    }
}
