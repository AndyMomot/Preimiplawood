//
//  SearchBar.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .foregroundStyle(Colors.darkGrey.swiftUIColor)
                .frame(width: 14, height:  14)
            
            TextField(text: $text) {
                Text("Szukaj")
                    .foregroundStyle(Colors.darkGrey.swiftUIColor)
                    .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 10))
            }
            .foregroundStyle(Colors.darkBlue.swiftUIColor)
            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 10))
        }
        .padding(12)
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(Colors.darkGrey.swiftUIColor, lineWidth: 1)
        }
    }
}

#Preview {
    SearchBar(text: .constant(""))
}
