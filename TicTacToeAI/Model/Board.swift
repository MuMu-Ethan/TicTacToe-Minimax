//
//  Board.swift
//  TicTacToeAI
//
//  Created by MuMu on 12/12/24.
//

import Foundation

struct Board {
    var board: [Player?]

    var isFull: Bool {
        !board.contains(nil)
    }

    enum Player: CaseIterable {
        case playerX
        case playerO

        mutating func toggle() {
            switch self {
            case .playerX:
                self = .playerO
            case .playerO:
                self = .playerX
            }
        }
    }

    enum EndStatus {
        case xWin
        case oWin
        case tie
    }

    var avaliableMoves: [Int] {
        allMoves(for: nil)
    }

    init(board: Board? = nil) {
        if let board = board {
            self.board = board.board
        } else {
            self.board = .init(repeating: nil, count: 9)
        }
    }

    func allMoves(for player: Player?) -> [Int] {
        var moves = [Int]()
        for (i, p) in board.enumerated() {
            if p == player {
                moves.append(i)
            }
        }
        return moves
    }

    func checkWinner() -> EndStatus? {
        let winConditions: Set<Set<Int>> = [
            [0, 1, 2],
            [0, 3, 6],
            [0, 4, 8],
            [1, 4, 7],
            [2, 5, 8],
            [2, 4, 6],
            [3, 4, 5],
            [6, 7, 8],
        ]
        for player in Player.allCases {
            for condition in winConditions {
                if condition.isSubset(of: allMoves(for: player)) {
                    switch player {
                    case .playerX:
                        return .xWin
                    case .playerO:
                        return .oWin
                    }
                }
            }
        }
        if isFull {
            return .tie
        }

        return nil
    }
}
