//
//  CompleteView.swift
//  PacketQuest
//
//  Created by Ohara Yoji on 2024/02/26.
//

import SwiftUI

struct CompleteView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "party.popper")
                .resizable()
                .frame(width: 150, height: 150)
            VStack(spacing: 8) {
                Text("Congratulations!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                Text("You have now learned the IP address, Routing Table, Destination IP, and NextHop!")
                    .font(.title3)
            }
        }
        .fontDesign(.rounded)
    }
}

#Preview {
    CompleteView()
}
