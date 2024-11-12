//
//  AddTransactionViewModel.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 12.11.2024.
//

import Foundation

extension AddTransactionView {
    final class ViewModel: ObservableObject {
        @Published var project: ProjectModel?
        @Published var isIncome = true
        @Published var amount = ""
        
        func getProject(with id: String) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let savedProject = DefaultsService.shared.projects.first(where: {
                    $0.id == id
                })
                
                DispatchQueue.main.async { [self] in
                    self.project = savedProject
                }
            }
        }
        
        func addTransaction(forProject id: String, completion: @escaping () -> Void) {
            DispatchQueue.global().async { [weak self] in
                guard let self,
                      let amount = Int(self.amount),
                      let index = DefaultsService.shared.projects.firstIndex(where: {$0.id == id})
                else { return }
                
                if self.isIncome {
                    DefaultsService.shared.projects[index].income.append(amount)
                } else {
                    DefaultsService.shared.projects[index].costs.append(amount)
                }
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
