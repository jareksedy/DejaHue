//
//  GameView.swift
//  DejaHue
//
//  Created by Ярослав Седышев on 02.09.2024.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                HStack {
                    Text("Spot duplicate colors 🎨 in the shortest possible time")
                        .lineSpacing(4)
                        .font(.system(size: 18, weight: .bold))
                        .bold()
                        .fontDesign(.rounded)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.appIndigo, .green],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .padding([.leading, .trailing], 25)
                        .padding([.top, .bottom], 25)
                    
                    Spacer()
                }
                .background(.white)
                .cornerRadius(Config.cornerRadius)
                .padding([.leading, .trailing], Config.padding)
                .background(
                    Image(systemName: "rhombus.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 36))
                        .offset(x: -51.5, y: 15)
                    , alignment: .bottomTrailing
                )
                
            
                Spacer()
                    .frame(height: 40)
                
                ScoreView(round: viewModel.round, health: viewModel.health, startDate: viewModel.startDate)

                LazyVGrid(
                    columns: viewModel.getColumns(),
                    spacing: Config.spacing
                ) {
                    ForEach(0...viewModel.getCount() - 1, id: \.self) { index in
                        Button("") {
                            withAnimation(.bouncy(duration: 0.5)) {
                                viewModel.handleUserInput(index)
                            }
                        }
                        .buttonStyle(
                            ColorButtonStyle(
                                color: viewModel.colors[index],
                                mark: viewModel.marks[index]
                            )
                        )
                    }
                }
                .padding(Config.padding)
                .navigationTitle("Deja 🐠 Hue")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.accent)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .padding(.top, -0.5)
                            .onTapGesture {
                                viewModel.preferencesPresented = true
                            }
                    }
                }
                .sheet(isPresented: $viewModel.preferencesPresented) {
                    PreferencesView(viewModel: viewModel)
                        .presentationDetents([.fraction(0.5)])
                        .presentationDragIndicator(.hidden)
                        .presentationCornerRadius(Config.presentationCornerRadius)
                }
            }
            .background(Color.appIndigoLight.ignoresSafeArea())
        }
    }
}

#Preview {
    MainTabView()
}

