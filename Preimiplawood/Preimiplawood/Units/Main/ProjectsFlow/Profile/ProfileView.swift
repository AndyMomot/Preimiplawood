//
//  ProfileView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var tabBarViewModel: TabBar.TabBarViewModel
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.addProjectBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: -bounds.width * 0.25) {
                Asset.profileBg.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        NavigationTitleView(showBackButton: true ,
                                            title: "Twój profil",
                                            color: .white)
                        .padding()
                    }
                
                ZStack {
                    Circle()
                        .foregroundStyle(.white)
                        .frame(width: bounds.width * 0.374,
                               height: bounds.width * 0.374)
                    
                    VStack(spacing: 0) {
                        Image(uiImage: viewModel.userImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: bounds.width * 0.34,
                                   height: bounds.width * 0.34)
                            .clipShape(Circle())
                            .clipped()
                            .overlay {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Button {
                                            viewModel.showImagePicker.toggle()
                                        } label: {
                                            Image(systemName: "pencil.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.white, Colors.liteBlue.swiftUIColor)
                                                .frame(width: 44, height: 44)
                                        }
                                    }
                                }
                            }
                            .shadow(radius: 1)
                        
                        ZStack {
                            VStack {
                                Circle()
                                    .fill(Colors.darkBlue.swiftUIColor)
                                    .frame(width: bounds.width * 0.34,
                                           height: bounds.width * 0.34)
                                Spacer()
                            }
                            
                            VStack(spacing: 30) {
                                HStack {
                                    Spacer()
                                    Text(viewModel.profile?.userName ?? "...")
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                                .padding(.top)
                                
                                VStack(alignment: .leading, spacing: 16) {
                                    var text: String {
                                        if viewModel.projects.isEmpty {
                                            return "Nie ma jeszcze żadnych projektów"
                                        } else {
                                            return "Twoje projekty"
                                        }
                                    }
                                    
                                    Text(text)
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                                        .padding(.horizontal, 16)
                                    ScrollView {
                                        VStack(spacing: 10) {
                                            ForEach(viewModel.projects) { project in
                                                ProjectCell(project: project) { _ in }
                                            }
                                        }
                                        .padding(.bottom, UIScreen.main.bounds.height * 0.12)
                                    }
                                    .scrollIndicators(.hidden)
                                }
                            }
                            .background(Colors.darkBlue.swiftUIColor)
                            .cornerRadius(48, corners: [.topLeft, .topRight])
                            .padding(.top, bounds.width * 0.05)
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.userImage)
        }
        .onAppear {
            viewModel.getProfile()
            viewModel.getProjects()
            DispatchQueue.main.async {
                withAnimation {
                    tabBarViewModel.showTabBar = false
                }
            }
        }
        .onChange(of: viewModel.profile) { _ in
            viewModel.getImage()
        }
        .onChange(of: viewModel.userImage) { _ in
            viewModel.saveImage()
        }
        .onDisappear {
            DispatchQueue.main.async {
                withAnimation {
                    tabBarViewModel.showTabBar = true
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
