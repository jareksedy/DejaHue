//
//  GameViewModel.swift
//  DejaHue
//
//  Created by Ярослав Седышев on 02.09.2024.
//


import SwiftUI

class GameViewModel: ObservableObject {
    @Published var colors: [Color] = []
    @Published var marks: [MarkType] = Array(repeating: .none, count: Config.maxCellCount)
    
    @Published var health: Int = 3
    @Published var round: Int = 0
    
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var startDate = Date.now
    
    private var gridSize: GridSize = .grid4x4
    private var gameDifficulty: GameDifficulty = .medium
    
    private var duplicateIndices: IndexSet = []
    
    init() {
        generateColors()
    }
    
    func setGameOptions(gameDifficulty: GameDifficulty = .medium, gridSize: GridSize = .grid4x4) {
        guard (gameDifficulty != self.gameDifficulty) || (gridSize != self.gridSize) else {
            return
        }
        self.gameDifficulty = gameDifficulty
        self.gridSize = gridSize
        restartRound(restartGame: true)
    }
    
    func getColumns() -> [GridItem] {
        return Array(
            repeating: GridItem(
                .flexible(minimum: 5),
                spacing: Config.spacing
            ),
            count: gridSize.rawValue)
    }
    
    func getCount() -> Int {
        return gridSize.rawValue * gridSize.rawValue
    }
    
    func isCorrect(_ index: Int) -> Bool {
        colors.filter { $0 == colors[index] }.count > 1
    }
    
    func generateColors() {
        round += 1
        duplicateIndices = []
        marks = Array(repeating: .none, count: Config.maxCellCount)
        
        var colorSet = Set<Color>()
        let colorRange: ClosedRange<Double>
        
        switch gameDifficulty {
        case .easy: colorRange = 0.1...0.9
        case .medium: colorRange = 0.2...0.8
        case .hard: colorRange = 0.4...0.6
        }
        
        while colorSet.count < getCount() {
            let tempColor = Color.random(in: colorRange)
            colorSet.insert(tempColor)
        }
        
        while duplicateIndices.count < 2 {
            duplicateIndices.insert(.random(in: 0 ... getCount() - 1))
        }
        
        colors = Array(colorSet).shuffled()
        
        for index in duplicateIndices {
            colors[index] = colors[duplicateIndices.first!]
        }
    }
    
    func handleUserInput(_ index: Int) {
        guard marks[index] == .none else { return }
        
        if isCorrect(index) {
            Haptics.shared.play(.rigid)
            showCorrectColors()
            restartRound()
        } else {
            marks[index] = .xmark
            health -= 1
            if health > 0 { Haptics.shared.play(.heavy) }
        }
        
        if health <= 0 {
            Haptics.shared.notify(.error)
            showCorrectColors()
            restartRound(restartGame: true)
        }
    }
    
    private func showCorrectColors() {
        for index in duplicateIndices {
            marks[index] = .checkmark
        }
    }
    
    private func restartRound(restartGame: Bool = false) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withAnimation(.smooth(duration: 1)) {
                self.generateColors()
                
                if restartGame {
                    self.health = 3
                    self.round = 1
                    self.startDate = Date.now
                }
            }
        }
    }
}
