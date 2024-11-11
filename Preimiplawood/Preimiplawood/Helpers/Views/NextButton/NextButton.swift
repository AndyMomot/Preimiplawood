//
//  NextButton.swift
//  Libarorent
//
//  Created by Andrii Momot on 08.10.2024.
//

import SwiftUI

struct NextButton: View {
    var title: String
    var style: Style = .primary
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                style.bgColor
                
                Text(title)
                    .foregroundStyle(style.textColor)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 8)
                
            }
            .cornerRadius(8, corners: .allCorners)
            .shadow(color: Colors.darkBlue.swiftUIColor.opacity(0.1), radius: 8)
        }
    }
}

extension NextButton {
    enum Style {
        case primary
        case secondary(txtColor: Color, bgColor: Color)
        
        var bgColor: Color {
            switch self {
            case .primary:
                return Colors.darkBlue.swiftUIColor
            case .secondary(_, let bgColor):
                return bgColor
            }
        }
        
        var textColor: Color {
            switch self {
            case .primary:
                return .white
            case .secondary(let textColor, _):
                return textColor
            }
        }
    }
}

#Preview {
    ZStack {
        VStack(spacing: 20) {
            NextButton(title: "Komputeryrerererer") {}
                .frame(width: 200, height: 44)
            
            NextButton(title: "Komputeryrerererer", style: .secondary(txtColor: .white, bgColor: .blue)) {}
                .frame(width: 200, height: 44)
        }
    }
}
