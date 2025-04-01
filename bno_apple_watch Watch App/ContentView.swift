import SwiftUI


import SwiftUI
import Foundation
import UIKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HStack(spacing: 0) {
                NavigationLink(destination: Randomview())
                {
                    Text("전체 음식 랜덤돌리기")
                        .font(.custom("NotoSansOriya-Bold", size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                }
                .buttonStyle(WatchButtonStyle())
                
                Divider()
                
                Button(action: {
                    
                }) {
                    Text("선택 음식 랜덤돌리기")
                        .font(.custom("NotoSansOriya-Bold", size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                }
                .buttonStyle(WatchButtonStyle())
            }
        }
    }
}


struct WatchButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                Color(hex: "FDE8BB")
                    
                
            )
            
         
    }
}

#Preview {
    ContentView()
}
