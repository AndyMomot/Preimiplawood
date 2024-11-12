//
//  ReportingView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 12.11.2024.
//

import SwiftUI

struct ReportingView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.addProjectBg.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 22) {
                    CustomNavigationView(
                        image: viewModel.userImage,
                        nickname: viewModel.nickname
                    ) { action in
                        switch action {
                        case .onProfile:
                            viewModel.showProfile.toggle()
                        case .onShowSearch:
                            withAnimation {
                                viewModel.showSearchField.toggle()
                                if !viewModel.showSearchField {
                                    viewModel.searchText.removeAll()
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 90)
                    
                    VStack(spacing: 22) {
                        if viewModel.showSearchField {
                            SearchBar(text: $viewModel.searchText)
                                .padding(.horizontal, 16)
                        }
                        
                        HStack {
                            Text("Raportowanie przychodów i wydatków")
                                .foregroundStyle(Colors.darkBlue.swiftUIColor)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(viewModel.projects) { project in
                                    ReportCell(model: project)
                                        .onTapGesture {
                                            DispatchQueue.main.async {
                                                viewModel.projectIdToShow = project.id
                                                viewModel.showAddTransaction.toggle()
                                            }
                                        }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                        }
                        .scrollIndicators(.never)
                    }
                }
            }
            .onAppear {
                viewModel.getProfileData()
                viewModel.getProjects()
            }
            .navigationDestination(isPresented: $viewModel.showProfile) {
                ProfileView()
            }
            .navigationDestination(isPresented: $viewModel.showAddTransaction) {
                AddTransactionView(projectId: viewModel.projectIdToShow) {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        viewModel.successTitle = "Gratulacje!"
                        viewModel.successMessage = "Dodałeś nowy dochód! Szczegóły znajdziesz w zakładce menu „Raportowanie moich przychodów/wydatków”."
                        viewModel.showSuccessScreen.toggle()
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.showSuccessScreen) {
                SuccessView(title: viewModel.successTitle,
                            message: viewModel.successMessage)
            }
            .onChange(of: viewModel.searchText) { query in
                viewModel.performSearchWithDelay(query: query)
            }
            .hideKeyboardWhenTappedAround()
        }
    }
}

#Preview {
    ReportingView()
}
