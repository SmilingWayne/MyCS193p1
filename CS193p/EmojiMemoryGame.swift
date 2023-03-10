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

    static private var vehicleEmojis = ["๐", "๐ด", "โ๏ธ", "๐ต", "โต๏ธ", "๐", "๐", "๐", "๐ป", "๐", "๐", "๐", "๐", "๐", "๐ข", "๐ถ", "๐ฅ", "๐", "๐", "๐"]
    static private var animalEmojis = ["๐ถ", "๐ฑ", "๐ญ", "๐น", "๐ฐ", "๐ฆ", "๐ป", "๐ผ", "๐ปโโ๏ธ", "๐จ", "๐ฏ", "๐ฆ", "๐ฎ", "๐ท", "๐ต"]
    static private var foodEmojis = ["๐", "๐ฅ", "๐", "๐ฅ", "๐ฅ", "๐ฃ", "๐ช", "๐", "๐", "๐ฅ", "๐ญ", "๐ค", "๐ฅ", "๐ฆ", "๐", "๐"]
    static private var heartEmojis = ["โค๏ธ", "๐งก", "๐", "๐", "๐", "๐"]
    static private var sportsEmojis = ["โฝ๏ธ", "๐", "๐", "โพ๏ธ", "๐พ", "๐", "๐ฅ", "๐", "๐ฑ", "๐", "๐ธ", "๐", "๐ฅ", "๐ดโโ๏ธ", "๐", "๐งโโ๏ธ", "๐คบ", "๐", "๐๏ธโโ๏ธ", "โธ", "โท", "๐", "๐คผ"]
    static private var weatherEmojis = ["โ๏ธ", "๐ช", "โ๏ธ", "โ๏ธ", "โ๏ธ"]
    
    
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
