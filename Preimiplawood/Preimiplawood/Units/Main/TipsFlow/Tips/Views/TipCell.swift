//
//  TipCell.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 13.11.2024.
//

import SwiftUI

struct TipCell: View {
    var direction: Direction
    var title: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                direction.tipImage
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        Text(title)
                            .foregroundStyle(Colors.darkBlue.swiftUIColor)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                            .padding(.vertical, geo.size.height * 0.1)
                            .padding(.horizontal, geo.size.width * 0.2)
                    }
                
            }
        }
    }
}

extension TipCell {
    enum Direction {
        case left, right
        
        var tipImage: Image {
            switch self {
            case .left:
                return Asset.tipLeft.swiftUIImage
            case .right:
                return Asset.tipRight.swiftUIImage
            }
        }
    }
}

#Preview {
    TipCell(direction: .right,
            title: "Podstawowe techniki obróbki drewna")
    .padding()
}
