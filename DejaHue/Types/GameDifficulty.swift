//
//  GameDifficulty.swift
//  DejaHue
//
//  Created by Ярослав Седышев on 02.09.2024.
//

import Foundation

enum GameDifficulty: Int {
    case easy = 0
    case medium = 1
    case hard = 2
}

extension GameDifficulty {
    var gameDifficultyString: String {
        switch self {
        case .easy: return "easy"
        case .medium: return "medium"
        case .hard: return "hard"
        }
    }
}
