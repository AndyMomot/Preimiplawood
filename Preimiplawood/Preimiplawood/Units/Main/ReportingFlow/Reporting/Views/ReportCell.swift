//
//  ReportCell.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 12.11.2024.
//

import SwiftUI

struct ReportCell: View {
    var model: ProjectModel
    
    @State private var image = Asset.placeholder.swiftUIImage
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        HStack {
            HStack {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: bounds.width * 0.117,
                        height: bounds.width * 0.117
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 11))
                
                Text(model.name)
                    .foregroundStyle(Color.black)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 10))
            }
            
            Spacer()
            
            Text("\(model.profit)".toNumberFormat())
                .foregroundStyle(Colors.liteBlue.swiftUIColor)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 5) {
                Text("\(model.totalIncome)".toNumberFormat())
                    .foregroundStyle(Colors.greenCustom.swiftUIColor)
                Text("\(model.totalCosts)".toNumberFormat())
                    .foregroundStyle(Color.red)
            }
            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
        }
        .padding(10)
        .background(.white)
        .cornerRadius(11)
        .onAppear {
            getImage()
        }
    }
}

private extension ReportCell {
    func getImage() {
        let imageStorage = ImageStorageManager()
        DispatchQueue.global().async {
            imageStorage.fetchImage(with: model.id) { data in
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
    ZStack {
        Asset.addProjectBg.swiftUIImage
            .resizable()
            .ignoresSafeArea()
        
        ReportCell(model: .init(
            name: "Ekskluzywny wazon drewniany",
            description: "",
            date: .init(),
            price: 0,
            isDone: false,
            income: [4, 32, 542, 532, 23, 5432, 254, 654],
            costs: [432, 432, 65, 254, 543, 43, 23, 42]
        ))
        .padding()
    }
}
