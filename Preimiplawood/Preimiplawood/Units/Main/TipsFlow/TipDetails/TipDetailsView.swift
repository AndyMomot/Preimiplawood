//
//  TipDetailsView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 13.11.2024.
//

import SwiftUI

struct TipDetailsView: View {
    var item: TipModel
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var tabBarVM: TabBar.TabBarViewModel
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 22) {
                NavigationTitleView(
                    showBackButton: true,
                    title: item.title,
                    color: .darkBlue)
                .padding(.horizontal, 16)
                
                ZStack {
                    Asset.projectBg.swiftUIImage
                        .resizable()
                        .cornerRadius(24)
                        .padding(.horizontal, 16)
                    
                    ScrollView {
                        VStack(spacing: 30) {
                            ForEach(item.content, id: \.self) { text in
                                TipDescriptionCell(text: text)
                            }
                        }
                        .padding(30)
                        .background(.white)
                        .cornerRadius(11, corners: .allCorners)
                        .shadow(radius: 10)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 36)
                    }
                    .scrollIndicators(.never)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation {
                    tabBarVM.showTabBar = false
                }
            }
        }
        .onDisappear {
            DispatchQueue.main.async {
                withAnimation {
                    tabBarVM.showTabBar = true
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.showProfile) {
            ProfileView()
        }
    }
}

#Preview {
    TipDetailsView(item:
            .init(title: "Organizacja warsztatu",
                  content: [
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
                  ]))
}
