//
//  TipsView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 13.11.2024.
//

import SwiftUI

struct TipsView: View {
    @StateObject private var viewModel = ViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 22) {
                    CustomNavigationView(
                        image: viewModel.userImage,
                        nickname: viewModel.nickname,
                        showSearch: false
                    ) { action in
                        switch action {
                        case .onProfile:
                            viewModel.showProfile.toggle()
                        case .onShowSearch:
                            break
                        }
                    }
                    .frame(maxHeight: 90)
                    
                    Text("Wskazówki dotyczące organizacji pracy")
                        .foregroundStyle(Colors.darkBlue.swiftUIColor)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                    
                    
                    ZStack {
                        VStack(spacing: .zero) {
                            Rectangle()
                                .fill(Colors.darkBlue.swiftUIColor)
                                .frame(height: 3)
                            
                            Asset.tipBg.swiftUIImage
                                .resizable()
                        }
                        
                        ScrollView {
                            VStack(spacing: -bounds.width * 0.25) {
                                ForEach(viewModel.tips.indices, id: \.self) { index in
                                    
                                    var direction: TipCell.Direction {
                                        if index % 2 == 0 {
                                            return .left
                                        } else {
                                            return .right
                                        }
                                    }
                                    
                                    let item = viewModel.tips[index]
                                    
                                    HStack {
                                        if direction == .right {
                                            Spacer()
                                        }
                                        
                                        Button {
                                            viewModel.tipToShow = item
                                            viewModel.showTipDetails.toggle()
                                        } label: {
                                            TipCell(
                                                direction: direction,
                                                title: item.title)
                                            .frame(
                                                width: bounds.width * 0.5,
                                                height: bounds.width * 0.6
                                            )
                                        }
                                        
                                        if direction == .left {
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                }
            }
            .onAppear {
                viewModel.getProfileData()
            }
            .navigationDestination(isPresented: $viewModel.showProfile) {
                ProfileView()
            }
            .navigationDestination(isPresented: $viewModel.showTipDetails) {
                if let item = viewModel.tipToShow {
                    TipDetailsView(item: item)
                }
            }
        }
    }
}

#Preview {
    TipsView()
}
