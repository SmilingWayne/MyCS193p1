//
//  ContentView.swift
//  CS193p
//
//  Created by apple on 2023/1/16.
//

import SwiftUI

struct ContentView: View {
    //    @State var emojis :[String] = ["ðķ","ðđ","ð","ðĨ","ðĨŪ","ðŊ","ðĨ","ðĨ","ðđ","ðĻ","ðž","ð","âđïļââïļ","ð ","ð","ðŠ","ð","ð","ð","ð ","ð―","ð","ðŠļ","ðĶĨ"]
    //    @State var emoji_animals = ["ðķ","ðą","ð­","ð","ðĶïļ","ðš","ð·","ðļ","ð","ðĶ","ð","ðĶ","ð","ðŊ"] // set animals
    //    @State var emojiCount = 8
    //    @State var emoji_sports = ["ð§","ð","ð","ðĪš","ðī","ð","â―ïļ","ð","ðïļ","ðïļ"]
    //    @State var emoji_moods = ["ð","ðĨ°","ðŊ","ðĪŠ","âđïļ","ðĪŊ","ðģ","ð","ðĪ§"]
    
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
        var card: MemoryGame<String>.Card // å°―åŊč―å°å°äž éïžåŠéčĶCard @State:åūå°č§ïžå°―éäļčĶä―ŋįĻïž
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
