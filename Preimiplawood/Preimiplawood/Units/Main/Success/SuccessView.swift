//
//  SuccessView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import SwiftUI

struct SuccessView: View {
    var title: String
    var message: String
    
    @EnvironmentObject private var tabBarVM: TabBar.TabBarViewModel
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            Asset.successBg.swiftUIImage
                .resizable()
                .scaledToFit()
            
            ForEach(0..<Int.random(in: 4...6), id: \.self) { _ in
                Circle()
                    .fill(Colors.darkBlue.swiftUIColor)
                    .frame(width: randomSize(), height: randomSize())
                    .position(x: randomX(), y: randomY())
            }
            
            VStack(spacing: 40) {
                NavigationTitleView(showBackButton: true, title: "")
                    .padding(.top, 60)
                
                VStack(spacing: 20) {
                    Text(title)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 20))
                    Text(message)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 22))
                }
                .padding()
                .multilineTextAlignment(.center)
                .foregroundStyle(Colors.darkBlue.swiftUIColor)
                .background(Colors.darkGrey.swiftUIColor.opacity(0.1))
                .cornerRadius(44)
                .shadow(color: .white.opacity(0.5), radius: 1)
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.async {
                withAnimation {
                    tabBarVM.showTabBar = false
                }
            }
        }
        .onDisappear {
            DispatchQueue.main.async {
                withAnimation {
                    tabBarVM.showTabBar = true
                }
            }
        }
    }
}

private extension SuccessView {
    func randomSize() -> CGFloat {
        // Adjust range for different circle sizes
        CGFloat.random(in: 50...100)
    }
    
    func randomX() -> CGFloat {
        // Generate random X position within screen bounds
        CGFloat.random(in: 0...UIScreen.main.bounds.width)
    }
    
    func randomY() -> CGFloat {
        // Generate random Y position within screen bounds
        CGFloat.random(in: 0...UIScreen.main.bounds.height)
    }
}

#Preview {
    SuccessView(title: "Gratulacje!", message: "Pomyślnie dodałeś nowy projekt! Znajdziesz go w zakładce „Moje projekty”.")
}
