//
//  ProjectsView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 07.11.2024.
//

import SwiftUI

struct ProjectsView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 22) {
                CustomNavigationView(
                    image: viewModel.userImage,
                    nickname: viewModel.nickname
                )
                .frame(maxHeight: 90)
            
                ScrollView {
                    VStack(spacing: 22) {
                        HStack {
                            Text("Twoje projekty")
                                .foregroundStyle(Colors.darkBlue.swiftUIColor)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        
                        VStack(spacing: 10) {
                            HStack {
                                Text("W trakcie")
                                    .foregroundStyle(Colors.liteBlue.swiftUIColor)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 12))
                                Spacer()
                                Text("Wykonany")
                                    .foregroundStyle(Colors.greenCustom.swiftUIColor)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 12))
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            
                            Rectangle()
                                .foregroundStyle(Colors.darkGrey.swiftUIColor)
                                .frame(height: 1)
                        }
                    }
                }
                .scrollIndicators(.never)
            }
        }
    }
}

#Preview {
    ProjectsView()
}
