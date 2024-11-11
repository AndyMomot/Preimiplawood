//
//  CalculationTFTitleView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import SwiftUI

struct CalculationTFTitleView: View {
    var title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 11)
                .fill(Color.white)
            
            HStack(spacing: 0) {
                Text(title)
                    .foregroundStyle(Colors.darkBlue.swiftUIColor)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                    .padding(.horizontal, 12)
                Spacer()
            }
        }
    }
}

#Preview {
    ZStack {
        Colors.darkGrey.swiftUIColor
        CalculationTFTitleView(title: "Stracony czas")
            .frame(width: 137, height: 66)
    }
}
