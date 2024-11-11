//
//  ProjectCell.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 09.11.2024.
//

import SwiftUI

struct ProjectCell: View {
    var project: ProjectModel
    var onButton: (Bool) -> Void
    
    @State private var image = Asset.placeholder.swiftUIImage
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    
                    // Image
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: bounds.width * 0.33,
                            height: bounds.width * 0.33
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 11))
                    
                    // Text
                    VStack(alignment: .leading, spacing: 10) {
                        Text(project.description)
                            .foregroundStyle(.black)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 10))
                        
                        Text("\(project.price)".toNumberFormat())
                            .foregroundStyle(.black)
                            .font(Fonts.SFProDisplay.heavyItalic.swiftUIFont(size: 12))
                        
                        Text("do " + project.date.toString(format: .ddMMyy))
                            .foregroundStyle(
                                project.isDone ? Colors.greenCustom.swiftUIColor : Colors.liteBlue.swiftUIColor
                            )
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 12))
                    }
                    
                    // Indicator button
                    Button {
                        onButton(project.isDone)
                    } label: {
                        Circle()
                            .foregroundStyle(
                                project.isDone ? Colors.greenCustom.swiftUIColor : Colors.liteBlue.swiftUIColor
                            )
                            .frame(width: 64, height: 64)
                            .overlay {
                                var image: Image {
                                    if project.isDone {
                                        return Asset.fingerUp.swiftUIImage
                                    } else {
                                        return Asset.check.swiftUIImage
                                    }
                                }
                                
                                image
                                    .offset(x: -16)
                            }
                            .offset(x: 32)
                    }
                }
                
                HStack(spacing: 0) {
                    Text(project.name)
                        .foregroundStyle(.black)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                    Spacer(minLength: 10)
                    Text(project.isDone ? "Wykonany" : "W trakcie")
                        .foregroundStyle(
                            project.isDone ? Colors.greenCustom.swiftUIColor : Colors.liteBlue.swiftUIColor
                        )
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 12))
                }
                .padding(.trailing, 16)
            }
            .padding(.leading, 16)
            .padding(.vertical, 16)
            .background(.white)
            .cornerRadius(25)
            
        }
        .padding(16)
        .background(Asset.projectBg.swiftUIImage
            .resizable())
        .cornerRadius(25)
        .onAppear {
            getImage()
        }
    }
}

private extension ProjectCell {
    func getImage() {
        let imageStorage = ImageStorageManager()
        DispatchQueue.global().async {
            imageStorage.fetchImage(with: project.id) { data in
                guard let data,
                      let uiImage = UIImage(data: data)
                else { return }
                DispatchQueue.main.async {
                    image = Image(uiImage: uiImage)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 20) {
            ProjectCell(project: .init(
                name: "Ekskluzywny wazon drewniany",
                description: "Ekskluzywny wazon drewniany wykonany z drewna w kolorze ciemnobrązowym w stylu skandynawskim do salonu.",
                date: .init(timeIntervalSince1970: 0),
                price: 23_000,
                isDone: false
            )) { _ in }
            
            ProjectCell(project: .init(
                name: "Ekskluzywny wazon drewniany",
                description: "Ekskluzywny wazon drewniany wykonany z drewna w kolorze ciemnobrązowym w stylu skandynawskim do salonu.",
                date: .init(timeIntervalSince1970: 0),
                price: 23_000,
                isDone: true
            )) { _ in }
        }
        .padding(.horizontal)
    }
}
