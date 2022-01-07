import ARKit
import RealityKit
import SwiftUI

struct SetInCup: View {
    var body: some View {
        SetInCupARView()
    }
}

struct SetInCupARView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.debugOptions = [.showStatistics, .showFeaturePoints]
        
        let config = ARWorldTrackingConfiguration()
        config.detectionObjects = ARReferenceObject.referenceObjects(inGroupNamed: "AR Resources", bundle: nil)!
        arView.session.run(config, options: [])
        
        // 指定のコップにオブジェクトを設置
        let anchor = AnchorEntity(.object(group: "AR Resources", name: "cup"))
        let sphere = ModelEntity(mesh: .generateSphere(radius: 0.1))
        let material = SimpleMaterial(color: .green.withAlphaComponent(0.3), roughness: .float(0), isMetallic: true)
        sphere.model?.materials = [material]
        anchor.addChild(sphere)
        arView.scene.anchors.append(anchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
