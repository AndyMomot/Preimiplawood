//
//  AuthView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 07.11.2024.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    NavigationTitleView(title: "Cześć,  Powitanie!")
                        .padding(.leading)
                    
                    ZStack {
                        Circle()
                            .foregroundStyle(Colors.darkBlue.swiftUIColor)
                            .frame(width: bounds.width * 0.5)
                        
                            .overlay {
                                Asset.logo.swiftUIImage
                                    .resizable()
                                    .scaledToFit()
                                    .padding(50)
                                    .offset(
                                        x: -10,
                                        y: 10
                                    )
                            }
                            .offset(
                                x: bounds.width * 0.1,
                                y: -(bounds.height * 0.05)
                            )
                    }
                }
                
                InputField(
                    title: "Przydomek",
                    placeholder: "Wpisz swój pseudonim",
                    text: $viewModel.nickName)
                .padding(.horizontal)
                
                 Spacer()
                
                NextButton(title: "Wejść") {
                    viewModel.saveNickName()
                    viewModel.showMainFlow(rootViewModel: rootViewModel)
                }
                .frame(height: 52)
                .padding(.horizontal)
                .padding(.bottom)
                .disabled(viewModel.nickName.isEmpty)
                .opacity(viewModel.nickName.isEmpty ? 0.3 : 1)
            }
            .ignoresSafeArea(edges: .top)
        }
        .hideKeyboardWhenTappedAround()
    }
}

#Preview {
    AuthView()
}
