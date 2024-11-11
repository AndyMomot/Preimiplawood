//
//  CalculationInput.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import SwiftUI

struct CalculationInput: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 22) {
                    CustomNavigationView(
                        image: viewModel.userImage,
                        nickname: viewModel.nickname
                    )
                    .frame(maxHeight: 90)
                    
                    Text("Kalkulator kosztów wytworzenia")
                        .foregroundStyle(Colors.darkBlue.swiftUIColor)
                }
            }
        }
    }
}

#Preview {
    CalculationInput()
}
