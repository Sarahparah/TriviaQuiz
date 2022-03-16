//
//  SwiftUIView.swift
//  TriviaQuiz
//
//  Created by Yolanda Jonasson on 2022-03-16.
//

import SwiftUI

struct RainbowText: View {
    var body: some View {
        Home()
    }
}

struct RainbowText_Previews: PreviewProvider {
    static var previews: some View {
        RainbowText()
    }
}

struct Home: View {

    //Toggle for multicolors
    @State var multiColor = false

    var body: some View {
        VStack(spacing: 25) {

            TextShimmer(text: "Trivia Quiz")

            Toggle(isOn: $multiColor, label: {
                Text("Enable Multi Colors")
                    .font(.title)
                    .fontWeight(.bold)
            })
                .padding()

        }
        .preferredColorScheme(.dark)
    }
}

struct TextShimmer: View {

    var text: String
    @State var animation = false
    //@Binding var multiColors: Bool

    var body: some View {

        ZStack{
            Text(text)
                .font(.system(size: 75, weight: .bold))
                .foregroundColor(Color.white.opacity(0.25))

            //Multicolor text...

            HStack(spacing: 0) {
                ForEach(0..<text.count, id: \.self){index in

                    Text(String(text[text.index(text.startIndex, offsetBy:
                                                    index)]))
                        .font(.system(size: 75, weight: .bold))
                        .foregroundColor(randomColor())
                }
            }

            // Masking for shimmer effect
            .mask(
                Rectangle()
                // For some more effect we use gradient
                    .fill(

                        LinearGradient(gradient: .init(colors:
                                                        [Color.white.opacity(0.5), Color.white, Color.white.opacity(0.5)]),
                                       startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 70))
                    .padding(20)
                    .offset(x: -250)
                    .offset(x: animation ? 500 : 0)
            )
            .onAppear(perform: {
                DispatchQueue.main.async {
                    withAnimation(Animation.linear(duration:
                    2).repeatForever(autoreverses: false)){
                        animation.toggle()
                    }
                }
            })
        }
    }


    func randomColor() -> Color {
        let color = UIColor(red: 1, green: .random(in: 0...1),
                            blue: .random(in: 0...1), alpha: 1)

        return Color(color)
    }
}
