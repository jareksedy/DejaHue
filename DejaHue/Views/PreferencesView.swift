//
//  PreferencesView.swift
//  DejaHue
//
//  Created by Ярослав on 02.09.2024.
//

import SwiftUI

struct PreferencesView: View {
    @ObservedObject var viewModel: GameViewModel
    
    @State private var gridSizeSelected: GridSize = .grid4x4
    let gridSizeSegments: [GridSize] = [.grid3x3, .grid4x4, .grid5x5]
    
    @State private var gameDifficultySelected: GameDifficulty = .medium
    let gameDifficultySegments: [GameDifficulty] = [.easy, .medium, .hard]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Picker("Game difficulty", selection: $gameDifficultySelected) {
                    ForEach(gameDifficultySegments, id: \.self) {
                        Text($0.gameDifficultyString)
                    }
                }
                .pickerStyle(.segmented)
                
                Spacer().frame(height: Config.padding)
                
                Picker("Grid size", selection: $gridSizeSelected) {
                    ForEach(gridSizeSegments, id: \.self) {
                        Text($0.gridSizeString)
                    }
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                Button("Save") {
                    viewModel.setGameOptions(gameDifficulty: gameDifficultySelected, gridSize: gridSizeSelected)
                }
                .buttonStyle(BorderedProminentButtonStyle())
                
                Spacer().frame(height: Config.padding)
            }
            .padding(Config.padding)
            .background(.appIndigoLight)
            .navigationTitle("Game Options")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

