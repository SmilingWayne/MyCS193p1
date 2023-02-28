//
//  ContentView.swift
//  CS193p
//
//  Created by apple on 2023/1/16.
//

import SwiftUI

struct ContentView: View {
    //    @State var emojis :[String] = ["🐶","🐹","👜","🥘","🥮","🌯","🥙","🥃","🏹","🎨","🎼","🏆","⛹️‍♀️","🌠","💌","🪙","🌋","🚂","🚎","🎠","🍽","🍄","🪸","🦥"]
    //    @State var emoji_animals = ["🐶","🐱","🐭","🐍","🦁️","🐺","🐷","🐸","🐑","🦕","🐘","🦛","🐆","🐯"] // set animals
    //    @State var emojiCount = 8
    //    @State var emoji_sports = ["🧗","🏃","🏊","🤺","🚴","💃","⚽️","🏀","🏐️","🏓️"]
    //    @State var emoji_moods = ["😄","🥰","😯","🤪","☹️","🤯","😳","😂","🤧"]
    
    @ObservedObject var viewModel : EmojiMemoryGame
    var body: some View {

        VStack{
            ScrollView{
                LazyVGrid(columns:[GridItem(.adaptive(minimum: 80))]){
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture{
                                viewModel.choose(card)
                            }
                        
                    }
                }
                .foregroundColor(viewModel.chosenColor)
                .padding()
            }
        
            Button {
                viewModel.startNewGame()
            } label: {
                Text("New Game").font(.largeTitle)
            }
            .padding()
            .navigationTitle("Memorize \(viewModel.chosenTheme.ThemeName!)!")
           
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        
        static var previews: some View {
            let game = EmojiMemoryGame()
            ContentView(viewModel: game)
                .preferredColorScheme(
                    .light)
            ContentView(viewModel: game)
                .preferredColorScheme(
                    .dark)
            
        }
    }
    
    
    struct CardView: View {
        //    var content:String
        //    @State var isFaceUp: Bool = true
        var card: MemoryGame<String>.Card // 尽可能少地传递，只需要Card @State:很少见！尽量不要使用！
        var body: some View {
            
            ZStack{
                let shape = RoundedRectangle(cornerRadius: 20)
                
                
                if card.isFaceUp{
                    
                    shape
                        .fill()
                        .foregroundColor(.white)
                    shape
                        .strokeBorder(lineWidth: 3)
                        
                    
                    Text(card.content)
//                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .padding()
                        
                }
                else if card.isMatched{
                    shape.opacity(0)
                }
                else{
                    shape.fill()
                    
                }
                    
            }
        }
    }
    
}
