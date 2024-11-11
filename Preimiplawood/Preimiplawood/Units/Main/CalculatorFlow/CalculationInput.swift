//
//  CalculationInput.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import SwiftUI

struct CalculationInput: View {
    @StateObject private var viewModel = ViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 22) {
                    CustomNavigationView(
                        image: viewModel.userImage,
                        nickname: viewModel.profile?.userName ?? "",
                        showSearch: false
                    )
                    .frame(maxHeight: 90)
                    
                    HStack {
                        Text("Kalkulator kosztów wytworzenia")
                            .foregroundStyle(Colors.darkBlue.swiftUIColor)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    
                    ScrollView {
                        if viewModel.isInputState {
                            CalculationInputContentView(
                                titles: viewModel.titles,
                                materialCostsValue: $viewModel.materialCostsValue,
                                wastedTimeValue: $viewModel.wastedTimeValue,
                                toolCostsValue: $viewModel.toolCostsValue,
                                equipmentCostsValue: $viewModel.equipmentCostsValue) {
                                    viewModel.onCalculate()
                                }
                        } else {
                            CalculationResultView(amount: viewModel.calculationAmount) { isReset in
                                viewModel.handleCalculationResult(isReset: isReset)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .onAppear {
                viewModel.getProfile()
            }
            .hideKeyboardWhenTappedAround()
        }
    }
}

#Preview {
    CalculationInput()
}
