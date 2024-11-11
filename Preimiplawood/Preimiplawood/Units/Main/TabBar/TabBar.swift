//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            ProjectsView()
                .tag(TabBarSelectionView.projects.rawValue)
                .environmentObject(viewModel)
            
            Text("Calculator")
                .tag(TabBarSelectionView.calculator.rawValue)
            
            Text("Reporting")
                .tag(TabBarSelectionView.reporting.rawValue)
            
            Text("Tips")
                .tag(TabBarSelectionView.tips.rawValue)
        }
        .overlay {
            if viewModel.showTabBar {
                VStack {
                    Spacer()
                    TabBarCustomView(selectedItem: $viewModel.selection)
                        .frame(height: UIScreen.main.bounds.height * 0.12)
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
}

#Preview {
    TabBar()
}
