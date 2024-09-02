//
//  GameView.swift
//  DejaHue
//
//  Created by Ярослав Седышев on 02.09.2024.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()
    @State private var preferencesPresented: Bool = false
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
                        .foregroundStyle(LinearGradient(colors: [.accentColor, .green], startPoint: .leading, endPoint: .trailing))
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
                        .offset(x: -50, y: 15)
                    , alignment: .bottomTrailing
                )
                
            
                Spacer()
                    .frame(height: 50)
                
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
                .navigationTitle("Deja Hue")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        preferencesPresented.toggle()
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
                .sheet(isPresented: $preferencesPresented) {
                    StatsView()
                        .presentationDetents([.fraction(0.95)])
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

