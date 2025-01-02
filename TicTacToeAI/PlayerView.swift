//
//  PlayerView.swift
//  TicTacToeAI
//
//  Created by MuMu on 12/16/24.
//

import SwiftUI

struct PlayerView: View {
    
    var player: Board.Player
    var isDarkMode: Bool
    
    var body: some View {
        Image(
            systemName: player == .playerX
                ? "multiply" : "circlebadge"
        )
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding()
    }
}
