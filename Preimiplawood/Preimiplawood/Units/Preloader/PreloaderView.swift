//
//  PreloaderView.swift
//  Libarorent
//
//  Created by Andrii Momot on 06.10.2024.
//

import SwiftUI
import Combine

struct PreloaderView: View {
    
    @State private var timer: Timer?
    @State private var progress: Double = 0.0
    
    let onDidLoad = PassthroughSubject<Void, Never>()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack() {
            Asset.preloaderBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            
            VStack(spacing: 0) {
                VStack(spacing: 26) {
                    Asset.logo.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 80)
                    
                    Asset.logoText.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 67)
                }
                
                Spacer(minLength: 20)
                
                CircularProgressBar(
                    progress: progress,
                    showProgress: true,
                    trackColor: .clear,
                    progressColor: .white,
                    lineWidth: 4,
                    lineCap: .round
                )
                .frame(width: 100)
            }
            .padding(.vertical, 80)
            .background(Colors.darkBlue.swiftUIColor)
            .cornerRadius(46, corners: .allCorners)
            .padding(.horizontal, 31)
            .padding(.vertical, 62)
        }
        .onAppear {
            startTimer()
        }
    }
}

private extension PreloaderView {
    func startTimer() {
        stopTimer()
        
        timer = .scheduledTimer(withTimeInterval: 0.1,
                                repeats: true, block: { timer in
            let value = Double.random(in: 0.03...0.05)
            updateProgress(value: value)
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateProgress(value: Double) {
        DispatchQueue.main.async {
            if progress + value > 1 {
                progress = 1
                stopTimer()
                onDidLoad.send()
            } else {
                progress = progress + value
            }
            
            
        }
    }
}

#Preview {
    PreloaderView()
}
