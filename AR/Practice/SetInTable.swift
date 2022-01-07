import ARKit
import RealityKit
import SwiftUI

struct SetInTable: View {
    var body: some View {
        SetInTableARView()
    }
}

struct SetInTableARView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.debugOptions = [.showStatistics, .showFeaturePoints]
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        arView.session.run(config, options: [])
        
        // 机にオブジェクトを設置
        let anchor = AnchorEntity(plane: .horizontal, classification: .table, minimumBounds: [0.2, 0.2])
        let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.1, 0.03, 0.05)))
        anchor.addChild(box)
        arView.scene.anchors.append(anchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
