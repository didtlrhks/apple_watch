//
//  RolletView.swift
//  bno_apple_watch Watch App
//
//  Created by 양시관 on 4/1/25.
//
import WatchKit
import SwiftUI
import Foundation

struct RouletteView: View {
    let foods: [Food]
    let subject: [String]
    @Environment(\.dismiss) private var dismiss
    @State private var selectedFood: Food?
    @State private var isSpinning = false
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    private func getButtonSize() -> CGFloat {
        let screenWidth = WKInterfaceDevice.current().screenBounds.width
        if screenWidth <= 180 { // 38mm
            return 12
        } else if screenWidth <= 200 { // 40mm
            return 14
        } else if screenWidth <= 220 { // 41mm
            return 16
        } else { // 44mm, 45mm, 49mm
            return 18
        }
    }
    
    private func getImageSize() -> CGFloat {
        let screenWidth = WKInterfaceDevice.current().screenBounds.width
        if screenWidth <= 180 { // 38mm
            return 60
        } else if screenWidth <= 200 { // 40mm
            return 70
        } else if screenWidth <= 220 { // 41mm
            return 80
        } else { // 44mm, 45mm, 49mm
            return 90
        }
    }
    
    private func getButtonWidth() -> CGFloat {
        let screenWidth = WKInterfaceDevice.current().screenBounds.width
        if screenWidth <= 180 { // 38mm
            return 120
        } else if screenWidth <= 200 { // 40mm
            return 140
        } else if screenWidth <= 220 { // 41mm
            return 170
        } else { // 44mm, 45mm, 49mm
            return 145
        }
    }
    
    private func getButtonHeight() -> CGFloat {
        let screenWidth = WKInterfaceDevice.current().screenBounds.width
        if screenWidth <= 180 { // 38mm
            return 42
        } else if screenWidth <= 200 { // 40mm
            return 40
        } else if screenWidth <= 220 { // 41mm
            return 45
        } else { // 44mm, 45mm, 49mm
            return 44
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(hex: "FDE8BB")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer(minLength: 0)
                    VStack(spacing:8){
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.0))
                                .frame(width:70, height: 70)
                            
                            if !foods.isEmpty {
                                Image(foods[currentIndex].imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .imageScale(.large)
                                    .font(.custom("NotoSansOriya-Bold", size: 16))
                            }
                        }
                    }
                        
                        VStack{
                            if let selectedFood = selectedFood {
                                Text(selectedFood.name)
                                    .font(.custom("NotoSansOriya-Bold", size: getButtonSize() + 2))
                                    .bold()
                                    .foregroundColor(.black)
                            } else {
                                Text("메뉴를 선택해주세요")
                                    .font(.custom("NotoSansOriya-Bold", size: getButtonSize() + 2))
                                    .foregroundColor(.gray)
                            }
                            
                            
                            
                            Button(action: {
                                if !foods.isEmpty {
                                    startSpinning()
                                }
                            }) {
                                Text("메뉴 선택하기")
                                    .font(.custom("NotoSansOriya-Bold", size: getButtonSize() + 2))
                                    .foregroundColor(.white)
                                    .frame(width: getButtonWidth(), height: getButtonHeight())
                                    .background(Color(hex: "FF6B35"))
                                    .cornerRadius(15)
                            }
                            .allowsHitTesting(!isSpinning && !foods.isEmpty)
                        }.padding(.bottom,10)
                            .padding(.horizontal)
                            Spacer()
                    }
                    
                
            }
            
        }
    }
    
    private func startSpinning() {
        guard !foods.isEmpty else { return }
        
        isSpinning = true
        selectedFood = nil
        currentIndex = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            guard !foods.isEmpty else {
                timer?.invalidate()
                timer = nil
                isSpinning = false
                return
            }
            currentIndex = (currentIndex + 1) % foods.count
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            timer?.invalidate()
            timer = nil
            
            guard !foods.isEmpty else {
                isSpinning = false
                return
            }
            
            let randomIndex = Int.random(in: 0..<foods.count)
            selectedFood = foods[randomIndex]
            currentIndex = randomIndex
            
            isSpinning = false
        }
    }
}
