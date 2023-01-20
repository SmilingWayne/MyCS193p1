//
//  CS193pApp.swift
//  CS193p
//
//  Created by apple on 2023/1/16.
//

import SwiftUI

@main
struct CS193pApp: App {
    
    var body: some Scene {
        let game = EmojiMemoryGame()
        WindowGroup {
            ContentView(viewModel : game)
        }
    }
}
