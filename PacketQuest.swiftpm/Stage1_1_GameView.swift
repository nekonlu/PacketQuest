//
//  GameView.swift
//  PacketQuest
//
//  Created by Ohara Yoji on 2024/02/26.
//

import SwiftUI

struct Stage1_1_GameView: View {

    @State private var isShowingComputerProperties: Bool = false
    @State private var isShowingL3RouterProperties: Bool = false

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            Path { path in
                path.move(to: .init(x: 100, y: height / 2))
                path.addLine(to: .init(x: width / 2 - 100, y: height / 2))
            }
            .stroke(lineWidth: 3)
            Path { path in
                path.move(to: .init(x: width / 2 - 100, y: height / 2))
                path.addLine(to: .init(x: width - 480, y: height / 2))
            }
            .stroke(lineWidth: 3)
            .opacity(0.07)
            Image("Computer")
                .resizable()
                .frame(width: 150, height: 150)
                .position(x: 100, y: height / 2)
                .onTapGesture {
                    isShowingComputerProperties = true
                }
            Image("L3Router")
                .resizable()
                .frame(width: 150, height: 150)
                .position(x: width / 2 - 100, y: height / 2)
                .onTapGesture {
                    isShowingL3RouterProperties = true
                }
            Image(systemName: "network")
                .resizable()
                .frame(width: 300, height: 300)
                .opacity(0.07)
                .position(x: width - 300, y: height / 2)
            VStack(spacing: 8) {
                Text("The network layer is responsible for selecting the optimal path for sending data and transmitting it. Just like choosing the fastest or safest route when sending a letter, the network layer finds the best path for data transmission.")
                Text("The data to be sent is divided into small data called IP packets. This application is a game in which IP packets are delivered to the goal device by manipulating the routing table and IP address of the device!!")
                HStack {
                    Spacer()
                    NavigationLink {
                        Stage1_2_GameView()
                    } label: {
                        Text("Next")
                            .fontWeight(.bold)
                            .padding()
                            .foregroundStyle(.white)
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.primary)
                            }
                    }
                }
                Spacer()
            }
            .position(x: width - width / 4 - 30, y: height / 2)
            .frame(width: width / 2)
            .frame(maxHeight: .infinity)
            .fontDesign(.rounded)
            .font(.title3)
            .fontWeight(.bold)

        }
        .sheet(isPresented: $isShowingComputerProperties, content: {
            Text("Hello")
        })
        .sheet(isPresented: $isShowingL3RouterProperties, content: {
            Text("Hello")
        })
    }
}

#Preview {
    Stage1_1_GameView()
}
