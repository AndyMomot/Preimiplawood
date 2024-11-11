//
//  CalculationResultView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import SwiftUI

struct CalculationResultView: View {
    var amount: String
    var back: (_ isReset: Bool) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 30) {
                HStack {
                    Text("Wynik:")
                        .foregroundStyle(Colors.darkGrey.swiftUIColor)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                    Spacer()
                }
                
                Text(amount)
                    .foregroundStyle(Colors.liteBlue.swiftUIColor)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 24))
                    .padding(.horizontal)
                    .padding(.bottom, 30)
            }
            .padding(20)
            .background(.white)
            .cornerRadius(11, corners: .allCorners)
            .shadow(radius: 10)
            
            Spacer()
            
            NextButton(
                title: "Nowe obliczenia",
                style: .secondary(
                    txtColor: .white,
                    bgColor: Colors.liteBlue.swiftUIColor)) {
                        back(true)
                    }
                    .frame(height: 53)
            
            NextButton(title: "Zmień poprzednie dane") {
                back(false)
            }
            .frame(height: 53)
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 40)
        .background(
            Asset.projectBg.swiftUIImage.resizable()
        )
        .cornerRadius(25)
        .padding(.horizontal, 16)
    }
}

extension CalculationResultView {
    enum Action {
        case reset
        case edit
    }
}

#Preview {
    CalculationResultView(amount: "23 000") { _ in }
}
