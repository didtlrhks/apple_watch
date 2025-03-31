//
//  SplashView.swift
//  bno_apple_watch Watch App
//
//  Created by 양시관 on 3/31/25.
//

import Foundation
import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color(hex: "FDE8BB")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("SplashImage") // Assets에 추가한 스플래시 이미지 이름
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}



