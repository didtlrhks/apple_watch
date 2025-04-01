//
//  randomview.swift
//  bno_apple_watch Watch App
//
//  Created by 양시관 on 4/1/25.
//

import Foundation
import SwiftUI



struct Randomview: View {
    @State private var foods = [
        Food(name: "탕수육", imageName: "tansuyuk"),
        Food(name: "간장게장", imageName: "ganjanggejang"),
        Food(name: "짜장면", imageName: "jjajanmun"),
        Food(name: "짬뽕", imageName: "jjambbong"),
        Food(name: "볶음밥", imageName: "bookumbab"),
        Food(name: "불고기", imageName: "bulgogi"),
        Food(name: "오징어두루치기", imageName: "squid"),
        Food(name: "닭볶음탕", imageName: "dakbokum"),
        Food(name: "쌈밥", imageName: "ssambab"),
        Food(name: "비빔밥", imageName: "bibimbab"),
        Food(name: "생선구이", imageName: "sangsunggui"),
        Food(name: "청국장", imageName: "chunggukjang"),
        Food(name: "낚지볶음", imageName: "nakzibokum"),
        Food(name: "떡갈비", imageName: "ddukkalbi"),
        Food(name: "초밥", imageName: "chobab"),
        Food(name: "토마토스파게티", imageName: "tomatospageti"),
        Food(name: "주먹밥", imageName: "zumeokbab"),
        Food(name: "우동", imageName: "udong"),
        Food(name: "피자", imageName: "pizza"),
        Food(name: "햄버거", imageName: "hamburger"),
        Food(name: "김밥", imageName: "gimbab"),
        Food(name: "편의점 도시락", imageName: "dosirak"),
        Food(name: "샌드위치", imageName: "sandwich"),
        Food(name: "토스트", imageName: "toast"),
        Food(name: "쌀국수", imageName: "ssalguksu"),
        Food(name: "팟타이", imageName: "ppattai"),
        Food(name: "콩나물국밥", imageName: "kongnamol"),
        Food(name: "뼈해장국", imageName: "bbuhaejangguk"),
        Food(name: "샐러드", imageName: "salad"),
        Food(name: "떡볶이", imageName: "ddukboki"),
        Food(name: "칼국수", imageName: "kalguksu"),
        Food(name: "라면", imageName: "ramen"),
        Food(name: "물냉면", imageName: "mulnangmun"),
        Food(name: "핫도그", imageName: "hotdog"),
        Food(name: "밥버거", imageName: "babburger"),
        Food(name: "카레", imageName: "carre"),
        Food(name: "된장찌개", imageName: "danzzigae"),
        Food(name: "크림파스타", imageName: "krimpasta"),
        Food(name: "순댓국", imageName: "sundaeguk"),
        
    
    ]
    
    @State private var selectedFood: Food?
    @State private var isSpinning = false
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            
            Color(hex: "FDE8BB")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                Text("오늘의 점심은?")
                    .font(.custom("NotoSansOriya-Bold", size: 16))
                    .foregroundColor(.black)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.0))
                        .frame(width: 80, height: 80)
                    
                    Image(foods[currentIndex].imageName)
                        .imageScale(.large)
                        .font(.custom("NotoSansOriya-Bold", size: 16))
                }
                
                if let selectedFood = selectedFood {
                    Text(selectedFood.name)
                        .font(.headline)
                        .bold()
                } else {
                    Text("메뉴를 선택해주세요")
                        .font(.custom("NotoSansOriya-Bold", size: 16))
                        .foregroundColor(.gray)
                }
                
                Button(action: {
                    startSpinning()
                }) {
                    Text("메뉴 선택하기")
                        .font(.custom("NotoSansOriya-Bold", size: 16))
                        .foregroundColor(.white)
                        .frame(width: 180, height: 50)
                        .background(Color(hex: "FF6B35"))
                        .cornerRadius(15)
                }
                .allowsHitTesting(!isSpinning)
            }
            .padding(8)
        }
    }
    
    private func startSpinning() {
        isSpinning = true
        selectedFood = nil
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            currentIndex = (currentIndex + 1) % foods.count
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            timer?.invalidate()
            timer = nil
            
            let randomIndex = Int.random(in: 0..<foods.count)
            selectedFood = foods[randomIndex]
            currentIndex = randomIndex
            
            isSpinning = false
        }
    }
}




#Preview {
    Randomview()
}
