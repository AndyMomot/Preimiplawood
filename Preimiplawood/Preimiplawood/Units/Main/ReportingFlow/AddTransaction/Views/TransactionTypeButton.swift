//
//  TransactionTypeButton.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 12.11.2024.
//

import SwiftUI

struct TransactionTypeButton: View {
    var imageName: String
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 15) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 46)
                
                Text(title)
                    .foregroundStyle(Colors.darkBlue.swiftUIColor)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 40)
            .background(.white)
            .cornerRadius(11)
        }
    }
}

#Preview {
    ZStack {
        Color.cyan
        TransactionTypeButton(imageName: Asset.cost.name, title: "Koszt") {}
    }
}
