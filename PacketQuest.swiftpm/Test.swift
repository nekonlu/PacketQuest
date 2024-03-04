//
//  Test.swift
//  PacketQuest
//
//  Created by Ohara Yoji on 2024/02/25.
//

import SwiftUI

struct Test: View {

    @State var position: CGSize = .init(width: 200, height: 200)

    var drag: some Gesture {
        DragGesture(minimumDistance: 100)
            .onChanged { value in
                self.position = CGSize(
                    width: value.startLocation.x + value.translation.width,
                    height: value.startLocation.y + value.translation.height
                )
            }
            .onEnded { value in
                self.position = CGSize(
                    width: value.startLocation.x + value.translation.width,
                    height: value.startLocation.y + value.translation.height
                )
            }
    }

    var body: some View {
        VStack {
            Text("x: \(position.width)")
            Text("y: \(position.height)")

            ZStack {
                Image("Computer")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .position(x: position.width, y: position.height)
                    .gesture(drag)

                Image("L3Routetr")
                    .resizable()
                    .frame(width: 200, height: 200)
            }


        }
    }
}

#Preview {
    Test()
}
