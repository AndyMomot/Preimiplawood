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
        @Published var nickname: String = DefaultsService.shared.nickName ?? ""
        @Published var showAddProject: Bool = false
        @Published var projects: [ProjectModel] = []
        
        var successTitle: String = ""
        var successMessage: String = ""
        @Published var showSuccessScreen = false
        
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
        
        func updateProjectCompletion(status: Bool, id: String) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                guard let index = DefaultsService.shared.projects.firstIndex(where: {
                    $0.id == id
                }) else { return }
                DefaultsService.shared.projects[index].isDone = status
                self.getProjects()
            }
        }
    }
}
