//
//  ProjectsViewModel.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 07.11.2024.
//

import Foundation
import UIKit.UIImage

extension ProjectsView {
    final class ViewModel: ObservableObject {
        @Published var userImage: UIImage = Asset.placeholder.image
        @Published var nickname: String = ""
    }
}
