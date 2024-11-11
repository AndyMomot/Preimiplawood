//
//  CalculationInputViewModel.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import Foundation
import SwiftUI

extension CalculationInput {
    final class ViewModel: ObservableObject {
        @Published var userImage: UIImage = Asset.placeholder.image
        @Published var profile: ProfileModel?
        @Published var isInputState = true
        
        let titles = ["Koszty materiałów", "Stracony czas", "Koszty narzędzi", "Koszty sprzętu"]
        @Published var materialCostsValue = ""
        @Published var wastedTimeValue = ""
        @Published var toolCostsValue = ""
        @Published var equipmentCostsValue = ""
        var calculationAmount = "0"
        
        func getProfile() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let savedProfile = DefaultsService.shared.profile
                self.getImage()
                
                DispatchQueue.main.async { [self] in
                    self.profile = savedProfile
                }
            }
        }
        
        func getImage() {
            DispatchQueue.global().async { [weak self] in
                guard let self, let id = self.profile?.id else { return }
                        
                ImageStorageManager().fetchImage(with: id) { data in
                    guard let data,
                          let uiImage = UIImage(data: data)
                    else { return }
                    DispatchQueue.main.async {
                        self.userImage = uiImage
                    }
                }
            }
        }
        
        func onCalculate() {
            DispatchQueue.global().async { [weak self] in
                guard let self,
                      let materialCostsValueInt = Int(self.materialCostsValue),
                      let wastedTimeValueInt = Int(self.wastedTimeValue),
                      let toolCostsValueInt = Int(self.toolCostsValue),
                      let equipmentCostsValueInt = Int(self.equipmentCostsValue)
                else { return }
                
                let amount = materialCostsValueInt + wastedTimeValueInt + toolCostsValueInt + equipmentCostsValueInt
                let amountStr = "\(amount)".toNumberFormat()
                
                DispatchQueue.main.async { [self] in
                    self.calculationAmount = amountStr
                    self.isInputState = false
                }
            }
            
        }
        
        func handleCalculationResult(isReset: Bool) {
            isInputState = true
            
            if isReset {
                materialCostsValue = ""
                wastedTimeValue = ""
                toolCostsValue = ""
                equipmentCostsValue = ""
            }
        }
    }
}
