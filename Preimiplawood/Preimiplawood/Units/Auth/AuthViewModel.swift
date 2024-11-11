//
//  AuthViewModel.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 07.11.2024.
//

import Foundation

extension AuthView {
    final class ViewModel: ObservableObject {
        @Published var nickName = ""
        
        func saveNickName() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let profile = ProfileModel(userName: self.nickName)
                DefaultsService.shared.profile = profile
            }
        }
        
        func showMainFlow(rootViewModel: RootContentView.RootContentViewModel) {
            DispatchQueue.main.async {
                rootViewModel.setFlow(.main)
            }
        }
    }
}
