import SwiftUI

struct Food: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct ContentView: View {
    @State private var foods = [
        Food(name: "김치찌개", imageName: "fork.knife"),
        Food(name: "라면", imageName: "leaf"),
        Food(name: "비빔밥", imageName: "cup.and.saucer"),
        Food(name: "돈까스", imageName: "star"),
        Food(name: "국수", imageName: "leaf"),
        Food(name: "부대찌개", imageName: "heart")
    ]
    
    @State private var selectedFood: Food?
    @State private var isSpinning = false
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack(spacing: 10) {
            Text("오늘의 점심은?")
                .font(.title3)
                .bold()
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 80, height: 80)
                
                Image(systemName: foods[currentIndex].imageName)
                    .imageScale(.large)
                    .font(.system(size: 30))
            }
            
            if let selectedFood = selectedFood {
                Text(selectedFood.name)
                    .font(.headline)
                    .bold()
            } else {
                Text("메뉴를 선택해주세요")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            
            Button(action: {
                startSpinning()
            }) {
                Text("메뉴 선택하기")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .frame(width: 180, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            .allowsHitTesting(!isSpinning)
        }
        .padding(8)
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
    ContentView()
}
