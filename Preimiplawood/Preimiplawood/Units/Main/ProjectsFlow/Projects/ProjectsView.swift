//
//  ProjectsView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 07.11.2024.
//

import SwiftUI

struct ProjectsView: View {
    @StateObject private var viewModel = ViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
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
                            Text("Twoje projekty")
                                .foregroundStyle(Colors.darkBlue.swiftUIColor)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        
                        VStack(spacing: 10) {
                            HStack {
                                Text("W trakcie")
                                    .foregroundStyle(Colors.liteBlue.swiftUIColor)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 12))
                                Spacer()
                                Text("Wykonany")
                                    .foregroundStyle(Colors.greenCustom.swiftUIColor)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 12))
                                Spacer()
                                
                                Button {
                                    viewModel.showAddProject.toggle()
                                } label: {
                                    Asset.addProject.swiftUIImage
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundStyle(Colors.liteBlue.swiftUIColor)
                                        .scaledToFit()
                                        .frame(width: 24, height:  24)
                                        .padding(.horizontal, 10)
                                    
                                }
                            }
                            .padding(.horizontal, 16)
                            
                            Rectangle()
                                .foregroundStyle(Colors.darkGrey.swiftUIColor)
                                .frame(height: 1)
                        }
                        
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(viewModel.projects) { project in
                                    ProjectCell(project: project) { isDone in
                                        viewModel.updateProjectCompletion(status: !isDone, id: project.id)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                        }
                    }
                    .scrollIndicators(.never)
                }
            }
            .onAppear {
                viewModel.getProfileData()
                viewModel.getProjects()
            }
            .navigationDestination(isPresented: $viewModel.showAddProject) {
                AddProjectView {
                    viewModel.getProjects()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        viewModel.successTitle = "Gratulacje!"
                        viewModel.successMessage = "Pomyślnie dodałeś nowy projekt! Znajdziesz go w zakładce „Moje projekty”."
                        viewModel.showSuccessScreen.toggle()
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.showSuccessScreen) {
                SuccessView(title: viewModel.successTitle,
                            message: viewModel.successMessage)
            }
            .navigationDestination(isPresented: $viewModel.showProfile) {
                ProfileView()
            }
            .onChange(of: viewModel.searchText) { query in
                viewModel.performSearchWithDelay(query: query)
            }
        }
    }
}

#Preview {
    ProjectsView()
}
