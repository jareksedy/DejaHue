//
//  StatsView.swift
//  DejaHue
//
//  Created by Ярослав Седышев on 02.09.2024.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Item 1")
                }
                
                Section {
                    Text("Item 2")
                    Text("Item 3")
                    Text("Item 4")
                }
                
                Section {
                    Text("Item 5")
                    Text("Item 6")
                    Text("Item 7")
                }
            }
            .scrollContentBackground(.hidden)
            .background(.appIndigoLight)
            .navigationTitle("Game Stats")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

