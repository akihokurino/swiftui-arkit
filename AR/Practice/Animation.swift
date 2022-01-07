import ARKit
import RealityKit
import SwiftUI

struct Animation: View {
    var body: some View {
        AnimationARView()
    }
}

struct AnimationARView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.debugOptions = [.showStatistics, .showFeaturePoints]

        let anchor = AnchorEntity(world: simd_make_float3(0, 0, -0.2))

        let box1 = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.02, 0.01, 0.01), cornerRadius: 0.001))
        anchor.addChild(box1)
        arView.scene.anchors.append(anchor)
        box1.move(to: Transform(scale: simd_make_float3(1, 1, 1),
                                rotation: anchor.orientation,
                                translation: simd_make_float3(anchor.transform.translation.x + 0.05,
                                                              anchor.transform.translation.y,
                                                              anchor.transform.translation.z)),
                  relativeTo: anchor,
                  duration: 3,
                  timingFunction: .linear)

        let box2 = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.03, 0.03, 0.03), cornerRadius: 0.001))
        box2.position = simd_make_float3(-0.2, 0, -0.2)
        anchor.addChild(box2)
        arView.scene.anchors.append(anchor)
        box2.move(to: Transform(pitch: 0, yaw: 0, roll: 150 * .pi / 180),
                  relativeTo: anchor,
                  duration: 3,
                  timingFunction: .linear)

        let box3 = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.01, 0.01, 0.01), cornerRadius: 0.001))
        box3.position = simd_make_float3(0.2, -0.5, -1.0)
        anchor.addChild(box3)
        arView.scene.anchors.append(anchor)
        box3.move(to: Transform(scale: simd_make_float3(3, 3, 3), rotation: anchor.orientation, translation: anchor.transform.translation),
                  relativeTo: anchor,
                  duration: 3)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}
