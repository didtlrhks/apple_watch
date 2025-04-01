import Foundation
import SwiftUI

struct SelecteRandomview: View {
    @State private var foods = [
        Food(name: "탕수육", imageName: "tansuyuk", subject: "중식"),
        Food(name: "간장게장", imageName: "ganjanggejang",subject: "한식"),
        Food(name: "짜장면", imageName: "jjajanmun",subject: "중식"),
        Food(name: "짬뽕", imageName: "jjambbong",subject: "중식"),
        Food(name: "볶음밥", imageName: "bookumbab",subject: "중식"),
        Food(name: "불고기", imageName: "bulgogi",subject: "한식"),
        Food(name: "오징어두루치기", imageName: "squid",subject: "한식"),
        Food(name: "닭볶음탕", imageName: "dakbokum",subject: "한식"),
        Food(name: "쌈밥", imageName: "ssambab",subject: "한식"),
        Food(name: "비빔밥", imageName: "bibimbab",subject: "한식"),
        Food(name: "생선구이", imageName: "sangsunggui",subject: "한식"),
        Food(name: "청국장", imageName: "chunggukjang",subject: "한식"),
        Food(name: "낚지볶음", imageName: "nakzibokum",subject: "한식"),
        Food(name: "떡갈비", imageName: "ddukkalbi",subject: "한식"),
        Food(name: "초밥", imageName: "chobab",subject: "일식"),
        Food(name: "토마토스파게티", imageName: "tomatospageti",subject: "양식"),
        Food(name: "주먹밥", imageName: "zumeokbab",subject: "일식"),
        Food(name: "우동", imageName: "udong",subject: "일식"),
        Food(name: "피자", imageName: "pizza",subject: "양식"),
        Food(name: "햄버거", imageName: "hamburger",subject: "양식"),
        Food(name: "김밥", imageName: "gimbab",subject: "간편식"),
        Food(name: "편의점 도시락", imageName: "dosirak",subject: "간편식"),
        Food(name: "샌드위치", imageName: "sandwich",subject: "간편식"),
        Food(name: "토스트", imageName: "toast",subject: "간편식"),
        Food(name: "쌀국수", imageName: "ssalguksu",subject: "기타"),
        Food(name: "팟타이", imageName: "ppattai",subject: "기타"),
        Food(name: "콩나물국밥", imageName: "kongnamol",subject: "해장"),
        Food(name: "뼈해장국", imageName: "bbuhaejangguk",subject: "해장"),
        Food(name: "샐러드", imageName: "salad",subject: "간편식"),
        Food(name: "떡볶이", imageName: "ddukboki",subject: "간편식"),
        Food(name: "칼국수", imageName: "kalguksu",subject: "기타"),
        Food(name: "라면", imageName: "ramen",subject: "해장"),
        Food(name: "물냉면", imageName: "mulnangmun",subject: "해장"),
        Food(name: "핫도그", imageName: "hotdog",subject: "간편식"),
        Food(name: "밥버거", imageName: "babburger",subject: "간편식"),
        Food(name: "카레", imageName: "carre",subject: "기타"),
        Food(name: "된장찌개", imageName: "danzzigae",subject: "탕찌개"),
        Food(name: "크림파스타", imageName: "krimpasta",subject: "양식"),
        Food(name: "순댓국", imageName: "sundaeguk",subject: "해장"),
        Food(name: "부대찌개", imageName: "budaezigae",subject: "탕찌개"),
        Food(name: "갈비탕", imageName: "galbitang",subject: "탕찌개"),
        Food(name: "삼계탕", imageName: "samgaetang",subject: "탕찌개"),
        Food(name: "라멘", imageName: "ramen_japan",subject: "일식"),
        Food(name: "덮밥", imageName: "dupbbap",subject: "일식"),
        Food(name: "메밀소바", imageName: "maemilsoba",subject: "일식"),
        Food(name: "돈가츠", imageName: "dongase",subject: "일식"),
        Food(name: "리조또", imageName: "rezoto",subject: "양식"),
        Food(name: "월남쌈", imageName: "wolnamssam",subject: "기타"),
        Food(name: "김치찌개", imageName: "gimchizzigae",subject: "탕찌개"),
        Food(name: "닭갈비", imageName: "dakgalbi",subject: "기타"),
        Food(name: "순두부", imageName: "sundubu",subject: "탕찌개"),
        Food(name: "포케", imageName: "poke",subject: "양식"),
        Food(name: "부리또", imageName: "buritto",subject: "기타"),
        Food(name: "보쌈", imageName: "bossam",subject: "한식"),
        Food(name: "잔치국수", imageName: "janchiguksu",subject: "한식"),
        Food(name: "제육", imageName: "jeyuok",subject: "한식")
    ]
    
    
   
    @State private var selectedSubjects: Set<String> = []
       @State private var showRouletteView = false
       
       private var subjects: [String] {
           let uniqueSubjects = Set(foods.map { $0.subject })
           return Array(uniqueSubjects).sorted()
       }
       
       private var filteredFoods: [Food] {
           if selectedSubjects.isEmpty {
               return []
           }
           
           return foods.filter { food in
               selectedSubjects.contains(food.subject)
           }
       }
       
       var body: some View {
           ZStack {
               Color(hex: "FDE8BB")
                   .edgesIgnoringSafeArea(.all)
               
               VStack(spacing: 10) {
                   Text("오늘의 점심은?")
                       .font(.custom("NotoSansOriya-Bold", size: 16))
                       .foregroundColor(.black)
                   
                   // Subject 선택 버튼들
                   ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 8) {
                           ForEach(subjects, id: \.self) { subject in
                               Button(action: {
                                   toggleSubject(subject)
                               }) {
                                   Text(subject)
                                       .font(.custom("NotoSansOriya-Bold", size: 14))
                                       .foregroundColor(selectedSubjects.contains(subject) ? .white : .black)
                                       .padding(.horizontal, 12)
                                       .padding(.vertical, 6)
                                       .background(
                                           selectedSubjects.contains(subject) ?
                                           Color(hex: "FF6B35") :
                                           Color.white
                                       )
                                       .cornerRadius(15)
                               }
                           }
                       }
                       .padding(.horizontal)
                   }
                   
                   
                   
                  
                   
                   Button(action: {
                       if !selectedSubjects.isEmpty {
                           showRouletteView = true
                       }
                   }) {
                       Text("다음")
                           .font(.custom("NotoSansOriya-Bold", size: 16))
                           .foregroundColor(.white)
                           .frame(width: 180, height: 50)
                           .background(Color(hex: "FF6B35"))
                           .cornerRadius(15)
                   }
                   .disabled(selectedSubjects.isEmpty)
               }
               .padding(8)
           }
           .sheet(isPresented: $showRouletteView) {
               RouletteView(foods: filteredFoods, subject: Array(selectedSubjects))
           }
       }
       
       private func toggleSubject(_ subject: String) {
           if selectedSubjects.contains(subject) {
               selectedSubjects.remove(subject)
           } else {
               selectedSubjects.insert(subject)
           }
       }
   }
#Preview {
    SelecteRandomview()
}
