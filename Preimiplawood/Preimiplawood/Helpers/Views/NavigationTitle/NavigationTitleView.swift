//
//  NavigationTitleView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 07.11.2024.
//

import SwiftUI

struct NavigationTitleView: View {
    var showBackButton: Bool = false
    var title: String
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack(spacing: 0) {
            if showBackButton {
                Button {
                    dismiss.callAsFunction()
                } label: {
                    Image(systemName: "chevron.left")
                        .padding(.trailing, 20)
                        .padding(.vertical, 5)
                }
            }
            
            Text(title)
            
            Spacer()
        }
        .foregroundStyle(Colors.darkBlue.swiftUIColor)
        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    VStack(spacing: 20) {
        NavigationTitleView(title: "Organizacja warsztatu")
        NavigationTitleView(showBackButton: true,
                            title: "Organizacja warsztatu")
    }
    .padding()
}
