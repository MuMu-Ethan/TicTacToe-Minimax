//
//  ContentView.swift
//  TicTacToeAI
//
//  Created by MuMu on 12/9/24.
//

import SwiftUI

struct ContentView: View {

    @State private var viewModel = TicTacToeAIViewModel()
    @Environment(\.colorScheme) var colorScheme

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var isDarkMode: Bool {
        colorScheme == .dark
    }

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(0..<9) { i in
                ZStack {
                    Color(isDarkMode ? .black : .white)
                    if let player = viewModel.board.board[i] {
                        PlayerView(player: player, isDarkMode: isDarkMode)
                    }
                }
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    viewModel.placeMark(
                        at: i, player: viewModel.currentPlayer)
                }

            }
        }
        .background {
            Color(isDarkMode ? .white : .black)
        }
        .onChange(
            of: viewModel.currentPlayer,
            { oldValue, newValue in
                if newValue == .playerO {
                        let bestMove = viewModel.bestMove()
                        viewModel.placeMark(at: bestMove, player: .playerO)
                }
            }
        )
        .padding(.horizontal, 40)
    }
}

#Preview {
    ContentView()
}
