//
//  TicTacToeAIViewModel.swift
//  TicTacToeAI
//
//  Created by MuMu on 12/9/24.
//

import Foundation

@Observable
class TicTacToeAIViewModel {
    var board = Board()

    var bestScores = [Int]()

    var currentPlayer = Board.Player.playerX

    func reset() {
        board = Board()
        currentPlayer = .playerX
    }

    func placeMark(at position: Int, player: Board.Player) {
        if board.board[position] == nil {
            board.board[position] = player
            if board.checkWinner() != nil {
                reset()
            } else {
                currentPlayer.toggle()
            }
        }
    }

    func minimax(isMaximizing: Bool, board: Board, alpha: Int, beta: Int) -> Int
    {

        if let winner = board.checkWinner() {
            switch winner {
            case .oWin:
                return 1
            case .xWin:
                return -1
            case .tie:
                return 0
            }
        }
        

        if isMaximizing {
            var alpha = alpha
            
            for move in board.avaliableMoves {
                var newBoard = board
                newBoard.board[move] = .playerO
                alpha = max(
                    alpha,
                    minimax(
                        isMaximizing: false,
                        board: newBoard,
                        alpha: alpha,
                        beta: beta
                    )
                )
                if alpha >= beta {
                    break
                }
                
            }
            return alpha

        } else {
            var beta = beta
            
            for move in board.avaliableMoves {
                var newBoard = board
                newBoard.board[move] = .playerX
                beta = min(
                    beta,
                    minimax(
                        isMaximizing: true,
                        board: newBoard,
                        alpha: alpha,
                        beta: beta
                    )
                )
                if alpha >= beta {
                    break
                }
            }
            return beta
        }
    }

    func bestMove() -> Int {
        var bestMove = 0

        var bestScore = Int.min
        for move in self.board.avaliableMoves {
            var newBoard = Board(board: board)
            newBoard.board[move] = .playerO
            let score = minimax(isMaximizing: false, board: newBoard, alpha: .min, beta: .max)
            if score > bestScore {
                bestScore = score
                bestMove = move
            }
        }
        return bestMove
    }
}
