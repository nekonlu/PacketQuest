//
//  Stage1_2_GameView.swift
//  PacketQuest
//
//  Created by Ohara Yoji on 2024/02/26.
//

import SwiftUI

struct Stage1_2_GameView: View {

    @Environment(\.dismiss) private var dismiss: DismissAction

    @ObservedObject private var viewmodel: Stage1_2_GameViewModel = .init()

    @State private var isShowingComputerProperties: Bool = false
    @State private var isShowingL3RouterProperties: Bool = false

    @State private var computerRTDeIP: String = ""
    @State private var computerRTNHIP: String = ""

    @State private var routerRTDeIPcom: String = ""
    @State private var routerRTNHIPcom: String = ""
    @State private var routerRTDeIPnet: String = ""
    @State private var routerRTNHIPnet: String = ""

    @State private var isResultAlert: Bool = false
    @State private var isSuccess: Bool = false

    @State private var isAlert: Bool = false

    @State private var isShowingPacket: Bool = false
    @State private var packetPosition: CGPoint?
    @State private var isAnimating = false

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
            VStack {
                Image("Computer")
                    .resizable()
                    .frame(width: 150, height: 150)
                Text(viewmodel.computer.IPv4.displayIP())
                Text("Start")
                    .fontWeight(.bold)
            }
            .position(x: 100, y: height / 2)
            .onTapGesture {
                isShowingComputerProperties = true
            }

            if isShowingPacket {
                if let pos = packetPosition {
                    Image("Packet")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .position(isAnimating ? .init(x: width - 480, y: height / 2) : pos)
                        .animation(.easeInOut(duration: 3), value: pos)
                        .onTapGesture {
                            self.isAnimating.toggle()
                        }
                }
            }

            VStack {
                Image("L3Router")
                    .resizable()
                    .frame(width: 150, height: 150)
                HStack {
                    Text("192.168.1.254/24")
                    Text("          10.255.255.254/8")
                }
            }
            .position(x: width / 2 - 100, y: height / 2)
            .onTapGesture {
                isShowingL3RouterProperties = true
            }

            VStack {
                Image(systemName: "network")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .opacity(0.07)
                Text("10.0.0.1/8")
                Text("Goal")
                    .fontWeight(.bold)
            }

            .position(x: width - 300, y: height / 2)

            VStack(spacing: 12) {
                Text("There are two important addresses in the L3 network: the Destination IP and the NextHop IP. First, let's send a packet from the computer labeled Start to the Internet labeled Goal.")
                Text("A next hop refers to the address of the next network device that a packet should be forwarded to. It allows routers or gateways to direct packets in the correct direction. The next hop is determined by a routing table and indicates the route for a packet to reach its final destination.")
                Text("Tap on Computer to open its properties, and enter \"10.0.0.0/8\" for the Destination IP and \"192.168.1.254/24\" for the NextHop IP in the Routing Table.")
                Text("Tap the Run button. If there is no problem, the packet should reach Goal safely!")

                Spacer()

                HStack {
                    Button {
                        if viewmodel.computer.routingTable.table[0].destinationNetwork.displayIP() == "10.0.0.0/8" &&
                            viewmodel.computer.routingTable.table[0].nexthop.displayIP() == "192.168.1.254/24" {
                            isResultAlert = true
                            isSuccess = true
                            isShowingPacket = true
                            packetPosition = CGPoint(x: 100, y: height / 2)
                            print("success")
                        } else {
                            isResultAlert = true
                            isSuccess = false
                        }
                    } label: {
                        Text("Run")
                            .fontWeight(.bold)
                            .padding()
                            .foregroundStyle(.white)
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.blue)
                            }
                    }
                    .alert(isSuccess ? "Congratulations! It's perfect!" : "Oops! I seem to have made a mistake somewhere!", isPresented: $isResultAlert) {

                    } message: {

                    }

                    Spacer()
                    NavigationLink {
                        CompleteView()
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
            }
            .position(x: width - width / 4 - 30, y: height / 2)
            .frame(width: width / 2)
            .frame(maxHeight: .infinity)
            .fontDesign(.rounded)
            .font(.title3)
            .fontWeight(.bold)

        }
        .sheet(isPresented: $isShowingComputerProperties,
               content: {
            NavigationStack {
                List {
                    Section("Default Properties(192.168.1.1/24)") {
                        HStack {
                            Text("This Computer IP")
                            Spacer()
                            Text(viewmodel.computer.IPv4.displayIP())
                        }
                    }
                    Section("Routing Table") {
                        HStack {
                            Text("Destination IP")
                            Spacer()
                            TextField(
                                viewmodel.computer.routingTable.table[0].destinationNetwork.displayIP(),
                                text: $computerRTDeIP
                            )
                                .frame(width: 200)
                        }
                        HStack {
                            Text("NextHop IP")
                            Spacer()
                            TextField(
                                viewmodel.computer.routingTable.table[0].nexthop.displayIP(),
                                text: $computerRTNHIP
                            )
                                .frame(width: 200)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            if let rtdeip =  IPv4.splitCIDRAddress(computerRTDeIP) ,
                               let rtnhip = IPv4.splitCIDRAddress(computerRTNHIP) {
                                viewmodel.computer.routingTable.table[0].destinationNetwork = rtdeip
                                viewmodel.computer.routingTable.table[0].nexthop = rtnhip
                                isAlert = false
                                return
                            } else {
                                isAlert = true
                                return
                            }
                        }
                        .alert("Error!", isPresented: $isAlert) {

                        } message: {
                            Text("Wrong IP address format.")
                        }
                    }
                }
                .navigationTitle("Computer")
            }
        })
        .sheet(isPresented: $isShowingL3RouterProperties, content: {
            NavigationStack {
                List {
                    Section("Default Properties") {
                        HStack {
                            Text("This Computer IP")
                            Spacer()
                            Text(viewmodel.computer.IPv4.displayIP())
                        }
                    }
                    Section("Routing Table(192.168.1.254/24)") {
                        HStack {
                            Text("Destination IP")
                            Spacer()
                            TextField("e.g. 192.168.32.32/24", text: $routerRTDeIPcom)
                                .frame(width: 200)
                        }
                        HStack {
                            Text("NextHop IP")
                            Spacer()
                            TextField("e.g. 192.168.32.32/24", text: $routerRTNHIPcom)
                                .frame(width: 200)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            if let rtdeip =  IPv4.splitCIDRAddress(routerRTDeIPcom) ,
                               let rtnhip = IPv4.splitCIDRAddress(routerRTNHIPnet) {
                                viewmodel.router.routingTable.table[0].destinationNetwork = rtdeip
                                viewmodel.router.routingTable.table[0].nexthop = rtnhip
                                isAlert = false
                                return
                            } else {
                                isAlert = true
                                return
                            }
                        }
                        .alert("Error!", isPresented: $isAlert) {

                        } message: {
                            Text("Wrong IP address format.")
                        }
                    }
                }
                .navigationTitle("L3 Router")
            }
        })
        .fontDesign(.rounded)
    }
}

#Preview {
    Stage1_2_GameView()
}
