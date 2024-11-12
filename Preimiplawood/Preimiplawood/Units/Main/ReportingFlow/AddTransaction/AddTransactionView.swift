//
//  AddTransactionView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 12.11.2024.
//

import SwiftUI

struct AddTransactionView: View {
    var projectId: String
    var didAdd: () -> Void
    
    @StateObject private var viewModel = ViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.addProjectBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 22) {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Colors.darkBlue.swiftUIColor)
                        .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                        .frame(height: bounds.height * 0.149)
                    
                    NavigationTitleView(showBackButton: true,
                                        title: "Nowa operacja",
                                        color: .white)
                    .padding(.top)
                    .padding(.horizontal)
                }
                
                ScrollView {
                    VStack(spacing: 20) {
                        HStack(spacing: 0) {
                            Spacer()
                            TransactionTypeButton(
                                imageName: Asset.income.name,
                                title: "Dochód") {
                                    withAnimation {
                                        viewModel.isIncome = true
                                    }
                                }
                                .overlay {
                                    RoundedRectangle(cornerRadius: 11)
                                        .stroke(Colors.greenCustom.swiftUIColor, lineWidth: 2)
                                        .padding(2)
                                        .opacity(viewModel.isIncome ? 1 : 0)
                                }
                            
                            Spacer(minLength: 10)
                            
                            TransactionTypeButton(
                                imageName: Asset.cost.name,
                                title: "Koszt") {
                                    withAnimation {
                                        viewModel.isIncome = false
                                    }
                                }
                                .overlay {
                                    RoundedRectangle(cornerRadius: 11)
                                        .stroke(Color.red, lineWidth: 2)
                                        .padding(2)
                                        .opacity(viewModel.isIncome ? 0 : 1)
                                }
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        
                        VStack(spacing: 50) {
                            VStack(spacing: 20) {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Projekt:")
                                        .foregroundStyle(Colors.darkBlue.swiftUIColor)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                    
                                    HStack {
                                        Text(viewModel.project?.name ?? "...")
                                            .foregroundStyle(Colors.darkBlue.swiftUIColor)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                        Spacer()
                                    }
                                }
                                
                                InputField(title: "Kwota",
                                           placeholder: "00",
                                           text: $viewModel.amount)
                                .keyboardType(.numberPad)
                            }
                            
                            NextButton(
                                title: "Dodaj",
                                style: .secondary(
                                    txtColor: .white,
                                    bgColor: Colors.liteBlue.swiftUIColor)) {
                                        viewModel.addTransaction(
                                            forProject: projectId) {
                                                didAdd()
                                            }
                                    }
                                    .frame(height: 53)
                        }
                        .padding(26)
                        .background(.white)
                        .cornerRadius(48)
                        .padding(.horizontal, 16)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .hideKeyboardWhenTappedAround()
        .ignoresSafeArea(edges: .top)
        .onAppear {
            viewModel.getProject(with: projectId)
        }
    }
}

#Preview {
    AddTransactionView(projectId: "") {}
}
