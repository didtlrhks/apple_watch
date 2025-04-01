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
//
//#Preview {
//    RouletteView(
//        foods: [
//            Food(name: "탕수육", imageName: "tansuyuk", subject: "중식"),
//            Food(name: "간장게장", imageName: "ganjanggejang",subject: "한식"),
//            Food(name: "짜장면", imageName: "jjajanmun",subject: "중식"),
//            Food(name: "짬뽕", imageName: "jjambbong",subject: "중식"),
//            Food(name: "볶음밥", imageName: "bookumbab",subject: "중식"),
//            Food(name: "불고기", imageName: "bulgogi",subject: "한식"),
//            Food(name: "오징어두루치기", imageName: "squid",subject: "한식"),
//            Food(name: "닭볶음탕", imageName: "dakbokum",subject: "한식"),
//            Food(name: "쌈밥", imageName: "ssambab",subject: "한식"),
//            Food(name: "비빔밥", imageName: "bibimbab",subject: "한식"),
//            Food(name: "생선구이", imageName: "sangsunggui",subject: "한식"),
//            Food(name: "청국장", imageName: "chunggukjang",subject: "한식"),
//            Food(name: "낚지볶음", imageName: "nakzibokum",subject: "한식"),
//            Food(name: "떡갈비", imageName: "ddukkalbi",subject: "한식"),
//            Food(name: "초밥", imageName: "chobab",subject: "일식"),
//            Food(name: "토마토스파게티", imageName: "tomatospageti",subject: "양식"),
//            Food(name: "주먹밥", imageName: "zumeokbab",subject: "일식"),
//            Food(name: "우동", imageName: "udong",subject: "일식"),
//            Food(name: "피자", imageName: "pizza",subject: "양식"),
//            Food(name: "햄버거", imageName: "hamburger",subject: "양식"),
//            Food(name: "김밥", imageName: "gimbab",subject: "간편식"),
//            Food(name: "편의점 도시락", imageName: "dosirak",subject: "간편식"),
//            Food(name: "샌드위치", imageName: "sandwich",subject: "간편식"),
//            Food(name: "토스트", imageName: "toast",subject: "간편식"),
//            Food(name: "쌀국수", imageName: "ssalguksu",subject: "기타"),
//            Food(name: "팟타이", imageName: "ppattai",subject: "기타"),
//            Food(name: "콩나물국밥", imageName: "kongnamol",subject: "해장"),
//            Food(name: "뼈해장국", imageName: "bbuhaejangguk",subject: "해장"),
//            Food(name: "샐러드", imageName: "salad",subject: "간편식"),
//            Food(name: "떡볶이", imageName: "ddukboki",subject: "간편식"),
//            Food(name: "칼국수", imageName: "kalguksu",subject: "기타"),
//            Food(name: "라면", imageName: "ramen",subject: "해장"),
//            Food(name: "물냉면", imageName: "mulnangmun",subject: "해장"),
//            Food(name: "핫도그", imageName: "hotdog",subject: "간편식"),
//            Food(name: "밥버거", imageName: "babburger",subject: "간편식"),
//            Food(name: "카레", imageName: "carre",subject: "기타"),
//            Food(name: "된장찌개", imageName: "danzzigae",subject: "탕찌개"),
//            Food(name: "크림파스타", imageName: "krimpasta",subject: "양식"),
//            Food(name: "순댓국", imageName: "sundaeguk",subject: "해장"),
//            Food(name: "부대찌개", imageName: "budaezigae",subject: "탕찌개"),
//            Food(name: "갈비탕", imageName: "galbitang",subject: "탕찌개"),
//            Food(name: "삼계탕", imageName: "samgaetang",subject: "탕찌개"),
//            Food(name: "라멘", imageName: "ramen_japan",subject: "일식"),
//            Food(name: "덮밥", imageName: "dupbbap",subject: "일식"),
//            Food(name: "메밀소바", imageName: "maemilsoba",subject: "일식"),
//            Food(name: "돈가츠", imageName: "dongase",subject: "일식"),
//            Food(name: "리조또", imageName: "rezoto",subject: "양식"),
//            Food(name: "월남쌈", imageName: "wolnamssam",subject: "기타"),
//            Food(name: "김치찌개", imageName: "gimchizzigae",subject: "탕찌개"),
//            Food(name: "닭갈비", imageName: "dakgalbi",subject: "기타"),
//            Food(name: "순두부", imageName: "sundubu",subject: "탕찌개"),
//            Food(name: "포케", imageName: "poke",subject: "양식"),
//            Food(name: "부리또", imageName: "buritto",subject: "기타"),
//            Food(name: "보쌈", imageName: "bossam",subject: "한식"),
//            Food(name: "잔치국수", imageName: "janchiguksu",subject: "한식"),
//            Food(name: "제육", imageName: "jeyuok",subject: "한식")
//        ],
//        subject: "양식",
//        subject: "한식",
//        subject: "기타",
//        subject: "탕찌개",
//        subject: "일식",
//        subject: "간편식",
//        subject: "해장",
//        subject: "중식"
//                
//        
//    )
//}
