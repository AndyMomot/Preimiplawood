//
//  CustomNavigationView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 07.11.2024.
//

import SwiftUI

struct CustomNavigationView: View {
    var image: UIImage
    var nickname: String
    var showSearch: Bool = true
    
    var onSearch: ((String) -> Void)?
    
    @State private var showSearchField: Bool = false
    @State private var searchText: String = ""
    
    @State private var searchWorkItem: DispatchWorkItem?
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                HStack(spacing: 15) {
                    // Image
                    ZStack {
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 67, height: 67)
                        
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 65, height: 65)
                            .clipShape(Circle())
                            .clipped()
                    }
                    
                    // Nickname
                    Text("Dzień dobry, ")
                        .foregroundColor(.white)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12)) +
                    Text(nickname)
                        .foregroundColor(Colors.liteBlue.swiftUIColor)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 12))
                    
                    Spacer()
                    
                    // Search
                    Button {
                        withAnimation {
                            showSearchField.toggle()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 24, height:  24)
                            
                    }

                }
                .padding(.top, geo.safeAreaInsets.top + 10)
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                .background(Colors.darkBlue.swiftUIColor)
                .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                
                if showSearchField {
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .foregroundStyle(Colors.darkGrey.swiftUIColor)
                            .frame(width: 14, height:  14)
                        
                        TextField(text: $searchText) {
                            Text("Szukaj")
                                .foregroundStyle(Colors.darkGrey.swiftUIColor)
                                .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 10))
                        }
                        .foregroundStyle(Colors.darkBlue.swiftUIColor)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 10))
                    }
                    .padding(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Colors.darkGrey.swiftUIColor, lineWidth: 1)
                    }
                    .padding(.horizontal, 16)
                }
            }
            .ignoresSafeArea(edges: .top)
            .onChange(of: searchText) { newValue in
                performSearchWithDelay(query: newValue)
            }
        }
    }
}

private extension CustomNavigationView {
    func performSearchWithDelay(query: String) {
            // Cancel any existing work item
            searchWorkItem?.cancel()
            
            // Create a new work item for the current search
            searchWorkItem = DispatchWorkItem {
                onSearch?(query)
            }
            
            // Schedule the work item to run after the delay
            if let workItem = searchWorkItem {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
            }
        }
}

#Preview {
    VStack {
        CustomNavigationView(image: Asset.placeholder.image,
                             nickname: "Nickname") { _ in }
        Spacer()
    }
}
