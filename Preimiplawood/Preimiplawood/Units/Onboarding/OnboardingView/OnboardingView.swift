//
//  OnboardingView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Image(item.image)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 50) {
                    Text(item.title)
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 20))
                    
                    VStack(spacing: 40) {
                        Button {
                            withAnimation {
                                currentPageIndex = item.next.rawValue
                            }
                            
                            if item == .third {
                                viewModel.showMainFlow(rootViewModel: rootViewModel)
                            }
                        } label: {
                            Text("Dalej")
                                .foregroundStyle(Colors.liteBlue.swiftUIColor)
                                .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 20))
                                .padding(.horizontal, 60)
                                .padding(.vertical, 14)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 48)
                                        .stroke(Colors.liteBlue.swiftUIColor, lineWidth: 2)
                                }
                        }
                        .frame(height: 53)
                        
                        HStack(spacing: 14) {
                            ForEach(0..<currentPageIndex + 1, id: \.self) { index in
                                Circle()
                                    .foregroundStyle(Colors.liteBlue.swiftUIColor)
                                    .frame(width: 12)
                            }
                            
                            ForEach(currentPageIndex..<item.max, id: \.self) { index in
                                Circle()
                                    .stroke(Colors.liteBlue.swiftUIColor, lineWidth: 1)
                                    .frame(width: 12)
                            }
                        }
                    }
                    
                    if item == .third {
                        Button {
                            viewModel.showPrivacyPolicy.toggle()
                        } label: {
                            HStack(spacing: 3) {
                                Text("Zgadzam się z")
                                    .foregroundStyle(.white)
                                Text("polityką prywatności")
                                    .foregroundStyle(Colors.liteBlue.swiftUIColor)
                                    .underline()
                            }
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                        }
                    }
                }
                .padding(42)
                .background(Colors.darkBlue.swiftUIColor.opacity(0.8))
                .cornerRadius(48, corners: .allCorners)
                .padding(.horizontal, 31)
                
                Button {
                    withAnimation {
                        currentPageIndex = item.max
                    }
                } label: {
                    Text("Pominąć")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                        .padding()
                }
            }
            .padding(.vertical)

        }
        .sheet(isPresented: $viewModel.showPrivacyPolicy) {
            SwiftUIViewWebView(url: viewModel.privacyPolicyURL)
        }
    }
}

#Preview {
    OnboardingView(item: .third, currentPageIndex: .constant(1))
}
