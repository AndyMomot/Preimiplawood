//
//  CalculationInputViewModel.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import Foundation
import UIKit.UIImage

extension CalculationInput {
    final class ViewModel: ObservableObject {
        @Published var userImage: UIImage = Asset.placeholder.image
        @Published var nickname: String = DefaultsService.shared.profile?.userName ?? ""
    }
}
