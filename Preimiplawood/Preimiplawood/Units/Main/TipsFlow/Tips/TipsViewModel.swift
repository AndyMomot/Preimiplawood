//
//  TipsViewModel.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 13.11.2024.
//

import Foundation
import UIKit.UIImage

extension TipsView {
    final class ViewModel: ObservableObject {
        @Published var showProfile = false
        @Published var userImage: UIImage = Asset.placeholder.image
        @Published var nickname: String = ""
        @Published var showTipDetails = false
        
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
        
        let tips: [TipModel] = [
            .init(
                title: "Wybór materiałów",
                content: [
                    """
                    Rodzaje drewna:
                    - Drewno miękkie (np. sosna, cedr) jest łatwiejsze w obróbce i świetne dla początkujących.
                    - Drewno twarde (np. dąb, klon) jest trwalsze i ma lepsze wykończenie, ale może być trudniejsze do ukształtowania.
                    """,
                    
                    """
                    Cięcie:
                    - Użyj piły ręcznej lub piły mechanicznej do prostych cięć. Ćwicz na odpadach drewnianych.
                    - Do krzywizn lepiej sprawdzi się piła wyrzynarka lub piła taśmowa.
                    """,
                    
                    """
                    Rozważ swój projekt:
                    - Pomyśl o końcowym przeznaczeniu (np. meble ogrodowe wymagają materiałów odpornych na warunki atmosferyczne).
                    - Dopasuj materiał do projektu i funkcjonalności swojego projektu.
                    """
                ]),
            
                .init(
                    title: "Podstawowe techniki obróbki drewna",
                    content: [
                        """
                        Pomiar i zaznaczanie:
                        - Użyj miarki krawieckiej i kątownika, aby uzyskać dokładne pomiary.
                        - Zaznacz miejsca nacięć ołówkiem i prostą krawędzią, aby zapewnić precyzję.
                        """,
                        
                        """
                        Sklejka kontra lite drewno:
                        - Sklejka jest wszechstronna i stabilna, co czyni ją dobrą do projektów meblowych.
                        - Lite drewno jest piękne i trwałe, ale może się odkształcać, jeśli nie zostanie odpowiednio zabezpieczone.
                        """,
                        
                        """
                        Łączenie:
                        - Gwoździe i śruby: Łatwe i skuteczne w przypadku większości połączeń.
                        - Klej: Użyj kleju do drewna, aby uzyskać mocne, trwałe połączenia; zaciskanie pomaga zabezpieczyć połączenie podczas wysychania.
                        - Jaskółczy ogon i połączenie czopowo-wpuszczane: Bardziej zaawansowane techniki mocniejszych połączeń w eleganckich meblach.
                        """,
                        
                        """
                        Szlifowanie:
                        - Zacznij od grubej gradacji (np. 80) i stopniowo przechodź do drobniejszej (np. 220), aby uzyskać gładkie wykończenie.
                        """,
                        
                        """
                        Wykończenie:
                        - Bejce, farby i lakiery mogą poprawić wygląd i chronić drewno.
                        - Zawsze testuj wykończenie na odpadach przed nałożeniem na projekt.
                        """
                    ]),
            
                .init(title: "Organizacja warsztatu", content: [
                    """
                    Przygotowanie stanowiska pracy:
                    - Zapewnij czyste, wyznaczone miejsce do cięcia, montażu i wykańczania projektów.
                    - Zapewnij dobre oświetlenie i wentylację.
                    """,
                    
                    """
                    Przechowywanie narzędzi:
                    - Użyj tablic perforowanych, skrzynek narzędziowych lub półek ściennych, aby utrzymać narzędzia w porządku i zapewnić do nich dostęp.
                    - Oznacz miejsca przechowywania, aby szybko znaleźć to, czego potrzebujesz.
                    """,
                    
                    """
                    Przechowywanie materiałów:
                    - Utrzymuj drewno i materiały w schludnym ułożeniu nad ziemią, aby zapobiec ich uszkodzeniu.
                    - Uporządkuj według rodzaju i rozmiaru, aby ułatwić dostęp.
                    """,
                    
                    """
                    Bezpieczeństwo przede wszystkim:
                    - Trzymaj sprzęt ochronny (okulary, rękawice, ochronę słuchu) w zasięgu ręki.
                    - Utrzymuj czyste przejścia i odpowiednio oznakuj i przechowuj niebezpieczne materiały.
                    """
                ])
        ]
        
        var tipToShow: TipModel?
    }
}
