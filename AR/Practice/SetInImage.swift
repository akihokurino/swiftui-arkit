import ARKit
import RealityKit
import SwiftUI

struct SetInImage: View {
    var body: some View {
        SetInImageARView()
    }
}

struct SetInImageARView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.debugOptions = [.showStatistics, .showFeaturePoints]
        
        let config = ARWorldTrackingConfiguration()
        config.detectionImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)!
        arView.session.run(config, options: [])
        
        // 指定の画像にオブジェクトを設置
        let anchor = AnchorEntity(.image(group: "AR Resources", name: "image-sample"))
        let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.03, 0.03, 0.03)))
        anchor.addChild(box)
        arView.scene.anchors.append(anchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
