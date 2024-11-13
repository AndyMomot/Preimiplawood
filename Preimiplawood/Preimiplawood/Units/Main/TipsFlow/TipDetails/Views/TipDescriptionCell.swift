//
//  TipDescriptionCell.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 13.11.2024.
//

import SwiftUI

struct TipDescriptionCell: View {
    var text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Asset.projectBg.swiftUIImage
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 25, height: 25)
            
            Text(text)
                .foregroundStyle(.darkBlue)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(fixedSize: 12))
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}

#Preview {
    TipDescriptionCell(
        text: """
Pomiar i zaznaczanie:
- Użyj miarki krawieckiej i kątownika, aby uzyskać dokładne pomiary.
- Zaznacz miejsca nacięć ołówkiem i prostą krawędzią, aby zapewnić precyzję.
""")
}
