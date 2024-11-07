//
//  TabBarCustomView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBarCustomView: View {
    @Binding var selectedItem: Int
    
    @State private var items: [TabBar.Item] = [
        .init(imageName: Asset.projectsTab.name),
        .init(imageName: Asset.calculatorTab.name),
        .init(imageName: Asset.reportingTab.name),
        .init(imageName: Asset.tipsTab.name)
    ]
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Colors.darkBlue.swiftUIColor)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .overlay {
                    HStack {
                        ForEach(items.indices, id: \.self) { index in
                            let item = items[index]
                            let isSelected = index == selectedItem
                            
                            Image(item.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                                .padding(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.white, lineWidth: 1)
                                        .opacity(isSelected ? 1 : 0)
                                }
                                .onTapGesture {
                                    selectedItem = index
                                }
                            
                            if index < items.count - 1 {
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, bounds.width * 0.1)
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    ZStack {
        
        VStack {
            Spacer()
            TabBarCustomView(selectedItem: .constant(0))
                .frame(height: 126)
        }
        .ignoresSafeArea()
    }
}
