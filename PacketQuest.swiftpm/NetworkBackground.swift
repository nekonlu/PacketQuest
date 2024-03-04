import SwiftUI

struct RandomNetworkView: View {
    let nodeCount: Int = 12 // ノードの数
    let nodeColor: Color = .green.opacity(0.1) // ノードの色
    let lineColor: Color = .gray.opacity(0.1) // 線の色
    let lineWidth: CGFloat = 3 // 線の太さ

    var body: some View {
        Canvas { context, size in
            // 画面サイズの150%を計算
            let extendedWidth = size.width * 1.2
            let extendedHeight = size.height * 1.2
            let xOffset = (extendedWidth - size.width) / 2
            let yOffset = (extendedHeight - size.height) / 2

            // ランダムなノードの位置を生成（画面サイズの150%の範囲で）
            let nodes = (0..<nodeCount).map { _ in CGPoint(x: CGFloat.random(in: -xOffset...size.width + xOffset),
                                                           y: CGFloat.random(in: -yOffset...size.height + yOffset)) }

            // ノード間を繋ぐ線を描画
            for i in 0..<nodes.count {
                for j in i+1..<nodes.count {
                    var path = Path()
                    path.move(to: nodes[i])
                    path.addLine(to: nodes[j])
                    context.stroke(path, with: .color(lineColor), lineWidth: lineWidth)
                }
            }

            // ノードを描画
            for node in nodes {
                context.fill(Path(ellipseIn: CGRect(x: node.x - 2.5, y: node.y - 2.5, width: 5, height: 5)), with: .color(nodeColor))
            }
        }
        .ignoresSafeArea()
    }
}

struct RandomNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        RandomNetworkView()
    }
}
