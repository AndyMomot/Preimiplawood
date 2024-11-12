//
//  ReportingViewModel.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 12.11.2024.
//

import Foundation
import UIKit.UIImage

extension ReportingView {
    final class ViewModel: ObservableObject {
        @Published var showProfile = false
        @Published var userImage: UIImage = Asset.placeholder.image
        @Published var nickname: String = ""
        
        @Published var showSearchField: Bool = false
        @Published var searchText: String = ""
        private var searchWorkItem: DispatchWorkItem?
        
        @Published var projects: [ProjectModel] = []
        var projectIdToShow = ""
        
        @Published var showAddTransaction = false
        
        var successTitle: String = ""
        var successMessage: String = ""
        @Published var showSuccessScreen = false
        
        func getProfileData() {
            DispatchQueue.global().async { [weak self] in
                guard let self,
                      let profile = DefaultsService.shared.profile
                else { return }
                
                DispatchQueue.main.async {
                    self.nickname = profile.userName
                }
                        
                ImageStorageManager().fetchImage(with: profile.id) { data in
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
