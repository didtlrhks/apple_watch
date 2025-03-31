import SwiftUI

struct Food: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct ContentView: View {
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

        
        
        
    ]
    
    @State private var selectedFood: Food?
    @State private var isSpinning = false
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            //FDE8BB
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


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    ContentView()
}
