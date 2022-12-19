//
//  ChatGPT.swift
//  LikeAnimation
//
//  Created by kekeli on 18/12/2022.
//

import SwiftUI

struct ChatGPT: View {
    @State private var isLiked = false
    @State private var isSplashing = false
    var body: some View {
        ZStack {
            if isLiked {
                // Pink-filled SF symbol heart icon
                Image (systemName: "heart.fill")
                    .resizable ()
                    .foregroundColor(.pink)
                    .frame (width: 25, height: 25)
                    .animation(.spring (), value: isLiked)
            } else {
                // Stroked SF symbol heart icon
                Image (systemName: "heart")
                    .resizable()
                    .foregroundColor (.pink)
                    .frame (width: 25, height: 25)
                    .animation (.spring(), value: isSplashing)
            }
            
            // Circle with stroke border of 0
            Circle()
                .stroke(lineWidth: 0)
                .frame (width: 25, height: 25)
                .animation (.easeOut (duration: 0.2), value: isLiked)
            if isSplashing {
                ForEach(0..<8, id: \.self) { index in
                    Circle()
                        .foregroundColor (self.color(for: index))
                        .frame (width: 6, height: 6)
                        .offset(x: 50)
                        .rotationEffect (.degrees (45 * Double(index)))
                }
            }
        }
//
        .onTapGesture {
            withAnimation(.spring()) {
                self.isLiked.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(Animation.easeOut(duration: 0.5)) {
                    self.isSplashing = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(Animation.easeOut(duration: 0.5)) {
                    self.isSplashing = false
                }
            }
        }
    }
    func color(for index: Int) -> Color {
        let colors: [Color] = [.pink, .red, .orange, .yellow, .green, .blue, .purple, .pink]
        return colors [index % colors.count]
    }
    }
struct ChatGPT_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPT()
    }
}
