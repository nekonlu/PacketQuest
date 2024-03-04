//
//  ConnectNodes.swift
//  PacketQuest
//
//  Created by Ohara Yoji on 2024/02/25.
//

import SwiftUI

struct Noder: Identifiable {
    let id = UUID()
    let name: String
}

struct NodeView: View {
    let node: Noder
    let onTap: () -> Void

    var body: some View {
        Circle()
            .foregroundColor(.blue)
            .frame(width: 50, height: 50)
            .overlay(
                Text(node.name)
                    .foregroundColor(.white)
            )
            .onTapGesture {
                onTap()
            }
    }
}

struct ConnectionView: View {
    var start: CGPoint
    var end: CGPoint

    var body: some View {
        Path { path in
            path.move(to: start)
            path.addLine(to: end)
        }
        .stroke(Color.red, lineWidth: 2)
    }
}

struct ConnectNodes: View {
    @State private var nodes: [Noder] = [
        Noder(name: "Node 1"),
        Noder(name: "Node 2"),
        Noder(name: "Node 3")
    ]
    @State private var selectedNode: Noder?

    var body: some View {
        ZStack {
            ForEach(nodes) { node in
                NodeView(node: node) {
                    selectedNode = node
                }
                .position(x: CGFloat.random(in: 50...300), y: CGFloat.random(in: 50...300))
            }
            if let selectedNode = selectedNode {
                ForEach(nodes) { node in
                    if node.id != selectedNode.id {
                        ConnectionView(start: CGPoint(x: selectedNode.id.hashValue, y: selectedNode.id.hashValue),
                                       end: CGPoint(x: node.id.hashValue, y: node.id.hashValue))
                    }
                }
            }
        }
    }
}

struct ConnectNodes_Previews: PreviewProvider {
    static var previews: some View {
        ConnectNodes()
    }
}


//struct ConnectNodes: View {
//    @State var position: CGSize = .init(width: 100, height: 0)
//    @State var isShowing: Bool = false
//
//    var drag: some Gesture {
//        DragGesture(minimumDistance: 0)
//            .onChanged { value in
//                self.position = CGSize(
//                    width: value.startLocation.x + value.translation.width,
//                    height: value.startLocation.y + value.translation.height
//                )
//            }
//            .onEnded { value in
//                self.position = CGSize(
//                    width: value.startLocation.x + value.translation.width,
//                    height: value.startLocation.y + value.translation.height
//                )
//                
//            }
//    }
//
//    var body: some View {
//        VStack {
//            Text("x: \(position.width)")
//            Text("y: \(position.height)")
//
//            GeometryReader { proxy in
//
//                Circle()
//                    .position(x: 100, y: 0)
//                    .frame(width: 30, height: 30)
//                    .onTapGesture {
//                        isShowing = true
//                    }
//                    .gesture(drag)
//
//                Circle()
//                    .position(x: proxy.size.width - 100, y: 0)
//                    .frame(width: 30, height: 30)
//                Path { path in
//                    path.move(to: .init(x: 100, y: 0))
//                    path.addLine(to: .init(x: position.width, y: position.height))
//                }
//                .stroke(lineWidth: 3)
//
//            }
//        }
//        .sheet(isPresented: $isShowing, content: {
//            Text("Hello")
//        })
//    }
//}

#Preview {
    ConnectNodes()
}
