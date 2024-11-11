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
        @Published var nickname: String = DefaultsService.shared.profile?.userName ?? ""
        @Published var showSearchField: Bool = false
        @Published var searchText: String = ""
        private var searchWorkItem: DispatchWorkItem?
        
        @Published var showAddProject: Bool = false
        @Published var projects: [ProjectModel] = []
        
        @Published var showProfile = false
        
        var successTitle: String = ""
        var successMessage: String = ""
        @Published var showSuccessScreen = false
        
        func getImage() {
            DispatchQueue.global().async { [weak self] in
                guard let self, let id = DefaultsService.shared.profile?.id else { return }
                        
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
        
        func getProjects() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let query = self.searchText
                var savedProjects: [ProjectModel] = []
                
                if query.isEmpty {
                    savedProjects = DefaultsService.shared.projects.sorted(by: {
                        $0.date < $1.date
                    })
                } else {
                    savedProjects = DefaultsService.shared.projects.filter {
                        $0.name.lowercased().contains(query.lowercased()) ||
                        $0.description.lowercased().contains(query.lowercased()) ||
                        "\($0.price)".lowercased().contains(query.lowercased())
                    }.sorted(by: {
                        $0.date < $1.date
                    })
                }
                
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
        
        func performSearchWithDelay(query: String) {
            // Cancel any existing work item
            searchWorkItem?.cancel()
            
            // Create a new work item for the current search
            searchWorkItem = DispatchWorkItem { [weak self] in
                guard let self else { return }
                self.getProjects()
            }
            
            // Schedule the work item to run after the delay
            if let workItem = searchWorkItem {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
            }
        }
    }
}
