//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://google.com")
        
        func showMainFlow(rootViewModel: RootContentView.RootContentViewModel) {
            DispatchQueue.main.async {
                rootViewModel.setFlow(.main)
            }
        }
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var image: String {
            switch self {
            case .first:
                return Asset.onboardBg1.name
            case .second:
                return Asset.onboardBg2.name
            case .third:
                return Asset.onboardBg3.name
            }
        }
        
        var title: String {
            switch self {
            case .first:
                return "Pomożemy początkującym i doświadczonym stolarzom zorganizować swoje projekty. Twórz karty z opisami zleceń, kosztami i terminami."
            case .second:
                return "Nasz kalkulator pomoże ci obliczyć koszt twojego projektu, biorąc pod uwagę materiały i czas. Kontrolowanie budżetu i optymalizowanie procesu produkcji staje się takie proste!"
            case .third:
                return "Poznaj nasze praktyczne wskazówki dotyczące wyboru materiałów i technik obróbki. Śledź koszty podczas oceny swojej działalności i planowania inwestycji."
            }
        }
        
        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
        
        var max: Int {
            OnboardingItem.allCases.last?.rawValue ?? 0
        }
    }
}
