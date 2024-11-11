//
//  AddProjectView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import SwiftUI

struct AddProjectView: View {
    @StateObject private var viewModel = ViewModel()
    var onAdd: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.addProjectBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Colors.darkBlue.swiftUIColor)
                        .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                        .frame(height: bounds.height * 0.149)
                    
                    NavigationTitleView(showBackButton: true,
                                        title: "Nowy projekt",
                                        color: .white)
                    .padding(.top)
                    .padding(.horizontal)
                }
                
                ScrollView {
                    VStack(spacing: 20)  {
                        InputField(
                            title: "Nazwa projektu",
                            placeholder: "Wpisz nazwę projektu",
                            text: $viewModel.name)
                        
                        DynamicHeightTextField(
                            title: "Opis projektu",
                            placeholder: "Wprowadź opis",
                            text: $viewModel.description)
                        .frame(minHeight: 100)
                        
                        DatePicker(
                            selection: $viewModel.date,
                            in: Date().addOrSubtract(component: .day, value: 1)...,
                            displayedComponents: [.date]) {
                                Text("Termin składania projektów")
                                    .foregroundStyle(Colors.darkBlue.swiftUIColor)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 28)
                            .overlay {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Colors.darkBlue.swiftUIColor, lineWidth: 1)
                                    .padding(2)
                            }
                        
                        InputField(
                            title: "Szacunkowa cena projektu",
                            placeholder: "00",
                            text: $viewModel.price)
                        .keyboardType(.numberPad)
                        
                        Button {
                            viewModel.showImagePicker.toggle()
                        } label: {
                            HStack(spacing: 20) {
                                if viewModel.image == Asset.addImageIcon.image {
                                    Image(uiImage: viewModel.image)
                                        .renderingMode(.template)
                                        .foregroundStyle(Colors.darkBlue.swiftUIColor)
                                        .padding(18)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Colors.darkBlue.swiftUIColor, lineWidth: 1)
                                                .padding(2)
                                        }
                                } else {
                                    Image(uiImage: viewModel.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 70, height: 70)
                                        .foregroundStyle(Colors.darkBlue.swiftUIColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                                
                                Text("Dodaj zdjęcie/szkic")
                                    .foregroundStyle(Colors.darkBlue.swiftUIColor)
                                    .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
                                Spacer()
                            }
                        }
                        
                        
                        HStack(spacing: 20) {
                            Text("Wykonany?")
                                .foregroundStyle(Colors.darkBlue.swiftUIColor)
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    viewModel.isDone.toggle()
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Colors.darkBlue.swiftUIColor, lineWidth: 1)
                                    .scaledToFit()
                                    .frame(width: 18)
                                    .overlay {
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(Colors.liteBlue.swiftUIColor)
                                            .opacity(viewModel.isDone ? 1 : 0)
                                            .padding(3)
                                    }
                                    .padding(.leading, 6)
                                    .padding(.vertical, 6)
                            }
                        }
                        
                        NextButton(title: "Dodaj nowy projekt") {
                            viewModel.addProject {
                                onAdd()
                                dismiss.callAsFunction()
                            }
                        }
                        .frame(height: 53)
                        .disabled(!viewModel.isValidFields)
                        .opacity(viewModel.isValidFields ? 1 : 0.5)
                    }
                    .padding(.vertical, 28)
                    .padding(.horizontal, 26)
                    .background(.white)
                    .cornerRadius(48)
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                }
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea(edges: .top)
        .hideKeyboardWhenTappedAround()
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.image)
        }
        .onChange(of: viewModel.name) { newValue in
            withAnimation {
                viewModel.validateFields()
            }
        }
        .onChange(of: viewModel.description) { newValue in
            withAnimation {
                viewModel.validateFields()
            }
        }
        .onChange(of: viewModel.price) { newValue in
            withAnimation {
                viewModel.validateFields()
            }
        }
        .onChange(of: viewModel.image) { newValue in
            withAnimation {
                viewModel.validateFields()
            }
        }
    }
}

#Preview {
    AddProjectView {}
}
