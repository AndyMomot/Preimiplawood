//
//  ProfileViewModel.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import Foundation
import UIKit.UIImage

extension ProfileView {
    final class ViewModel: ObservableObject {
        @Published var userImage: UIImage = Asset.placeholder.image
        @Published var profile: ProfileModel?
        @Published var projects: [ProjectModel] = []
        @Published var showImagePicker: Bool = false
        
        func getProfile() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let savedProfile = DefaultsService.shared.profile
                
                DispatchQueue.main.async { [self] in
                    self.profile = savedProfile
                }
            }
        }
        
        func getProjects() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let savedProjects = DefaultsService.shared.projects.sorted(by: {
                    $0.date < $1.date
                })
                
                DispatchQueue.main.async { [self] in
                    self.projects = savedProjects
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
        
        func saveImage() {
            DispatchQueue.global().async { [weak self] in
                guard let self,
                      let id = self.profile?.id,
                      let data = self.userImage.jpegData(compressionQuality: 1)
                else {
                    return
                }
                ImageStorageManager().saveImage(data: data, for: id)
            }
        }
    }
}
