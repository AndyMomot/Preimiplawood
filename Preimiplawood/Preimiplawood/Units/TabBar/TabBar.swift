//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = TabBarViewModel()
    @State private var showTabBar = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            Text("Projects")
                .tag(TabBarSelectionView.bicycles.rawValue)
            
            Text("Calculator")
                .tag(TabBarSelectionView.rentals.rawValue)
            
            Text("Reporting")
                .tag(TabBarSelectionView.catalog.rawValue)
            
            Text("Tips")
                .tag(TabBarSelectionView.settings.rawValue)
        }
        .overlay {
            if showTabBar {
                VStack {
                    Spacer()
                    TabBarCustomView(selectedItem: $viewModel.selection)
                        .frame(height: UIScreen.main.bounds.height * 0.1)
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
}

#Preview {
    TabBar()
}
