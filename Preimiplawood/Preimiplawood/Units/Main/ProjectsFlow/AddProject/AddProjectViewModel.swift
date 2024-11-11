//
//  AddProjectViewModel.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import Foundation
import UIKit.UIImage

extension AddProjectView {
    final class ViewModel: ObservableObject {
        @Published var name = ""
        @Published var description = ""
        @Published var date = Date()
        @Published var price = ""
        @Published var image: UIImage = Asset.addImageIcon.image
        @Published var isDone = false
        
        @Published var isValidFields = false
        @Published var showImagePicker: Bool = false
        
        func validateFields() {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.isValidFields = !self.name.isEmpty
                && !self.description.isEmpty
                && Int(self.price) ?? .zero > .zero
                && self.image != Asset.addImageIcon.image
            }
        }
        
        func addProject(completion: @escaping () -> Void) {
            guard isValidFields else { return }
            
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let project = ProjectModel(
                    name: self.name,
                    description: self.description,
                    date: self.date,
                    price: Int(self.price) ?? .zero,
                    isDone: self.isDone
                )
                
                DefaultsService.shared.projects.append(project)
                
                if let imageData = self.image.jpegData(compressionQuality: 1) {
                    ImageStorageManager().saveImage(data: imageData, for: project.id)
                }
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
