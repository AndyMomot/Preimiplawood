//
//  CalculationTFView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import SwiftUI

struct CalculationTFView: View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 11)
                .fill(Color.white)
            
            TextField(text: $text) {
                Text("00")
                    .foregroundStyle(Colors.darkGrey.swiftUIColor)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
            }
            .foregroundStyle(Colors.darkBlue.swiftUIColor)
            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
            .padding(.horizontal, 12)
        }
    }
}

#Preview {
    ZStack {
        Colors.darkGrey.swiftUIColor
        CalculationTFView(text: .constant(""))
            .frame(width: 137, height: 66)
    }
}
