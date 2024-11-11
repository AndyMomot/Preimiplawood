//
//  CalculationInputContentView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import SwiftUI

struct CalculationInputContentView: View {
    
    var titles: [String]
    @Binding var materialCostsValue: String
    @Binding var wastedTimeValue: String
    @Binding var toolCostsValue: String
    @Binding var equipmentCostsValue: String
    var calculate: () -> Void
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        VStack(spacing: 40) {
            HStack(spacing: 22) {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(titles, id: \.self) { title in
                        CalculationTFTitleView(title: title)
                            .frame(height: bounds.width * 0.16)
                    }
                }
                
                Rectangle()
                    .fill(.white)
                    .frame(width: 4)
                
                VStack(alignment: .leading, spacing: 20) {
                    CalculationTFView(text: $materialCostsValue)
                        .frame(height: bounds.width * 0.16)
                    
                    CalculationTFView(text: $wastedTimeValue)
                        .frame(height: bounds.width * 0.16)
                    
                    CalculationTFView(text: $toolCostsValue)
                        .frame(height: bounds.width * 0.16)
                    
                    CalculationTFView(text: $equipmentCostsValue)
                        .frame(height: bounds.width * 0.16)
                }
                .keyboardType(.numberPad)
            }
            
            NextButton(
                title: "Obliczać",
                style: .secondary(
                    txtColor: .white,
                    bgColor: Colors.liteBlue.swiftUIColor)) {
                        calculate()
            }
            .frame(height: 53)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 40)
        .background(
            Asset.projectBg.swiftUIImage.resizable()
        )
        .cornerRadius(25)
        .padding(.horizontal, 16)
    }
}

#Preview {
    CalculationInputContentView(
        titles: ["Koszty materiałów",
                 "Stracony czas", "Koszty narzędzi", "Koszty sprzętu"],
        materialCostsValue: .constant(""),
        wastedTimeValue: .constant(""),
        toolCostsValue: .constant(""),
        equipmentCostsValue: .constant("")) {}
}
