import AVFoundation
import RealityKit
import SwiftUI

struct HelloWorld: View {
    var body: some View {
        HelloWorldARView()
    }
}

struct HelloWorldARView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.debugOptions = [.showStatistics, .showFeaturePoints]

        let anchor = AnchorEntity()
        anchor.position = simd_make_float3(0, 0, 0)
        arView.scene.anchors.append(anchor)

        // 物理レンダリングの影響を受けないHelloWorld
        let textMesh = MeshResource.generateText(
            "Hello, world!",
            extrusionDepth: 0.1,
            font: .systemFont(ofSize: 1.0),
            containerFrame: CGRect.zero,
            alignment: .left,
            lineBreakMode: .byTruncatingTail)
        let textMaterial = UnlitMaterial(color: UIColor.blue)
        let textModel = ModelEntity(mesh: textMesh, materials: [textMaterial])
        textModel.scale = SIMD3<Float>(0.1, 0.1, 0.1)
        textModel.position = SIMD3<Float>(0.0, 0.0, -0.8)
        anchor.addChild(textModel)

        // 物理レンダリングの影響を受けるボックス
        let boxMesh = MeshResource.generateBox(size: 0.1)
        let boxMaterial = SimpleMaterial(color: UIColor.red, roughness: 0.0, isMetallic: true)
        let boxModel = ModelEntity(mesh: boxMesh, materials: [boxMaterial])
        boxModel.position = SIMD3<Float>(-0.1, -0.1, -0.6)
        anchor.addChild(boxModel)

        // 物理レンダリングの影響を受ける球体
        let sphereMesh = MeshResource.generateSphere(radius: 0.1)
        let sphereMaterial = SimpleMaterial(color: UIColor.white, roughness: 0.0, isMetallic: true)
        let sphereModel = ModelEntity(mesh: sphereMesh, materials: [sphereMaterial])
        sphereModel.position = SIMD3<Float>(0.5, -0.1, -0.6)
        anchor.addChild(sphereModel)

        // 画像ボックス
        if let url = Bundle.main.url(forResource: "image-sample", withExtension: "jpeg"),
           let path = Bundle.main.path(forResource: "image-sample", ofType: "jpeg"),
           let texture = try? TextureResource.load(contentsOf: url, withName: nil)
        {
            let size = getBoxSizeForImage(image: UIImage(contentsOfFile: path)!, boxWidth: 0.1)
            let imageBoxMesh = MeshResource.generateBox(size: size)
            var imageBoxMaterial = UnlitMaterial()
            imageBoxMaterial.baseColor = MaterialColorParameter.texture(texture)
            let imageBoxModel = ModelEntity(mesh: imageBoxMesh, materials: [imageBoxMaterial])
            imageBoxModel.position = SIMD3<Float>(0.1, -0.2, -0.8)
            let degree: Float = 160 * 180 / .pi
            imageBoxModel.orientation = simd_quatf(angle: degree, axis: [0, 3, 0])
            imageBoxModel.scale = SIMD3<Float>(2.0, 2.0, 2.0)
            anchor.addChild(imageBoxModel)
        }

        // 動画ボックス
        if let videoURL = Bundle.main.url(forResource: "video-sample", withExtension: "mp4") {
            let asset = AVURLAsset(url: videoURL)
            let playerItem = AVPlayerItem(asset: asset)
            let player = AVPlayer(playerItem: playerItem)
//            let size = getBoxSizeForVideo(url: videoURL, boxWidth: 0.1)
            let videoBoxMesh = MeshResource.generateBox(size: 0.3)
            let videoBoxMaterial = VideoMaterial(avPlayer: player)
            let videoBoxModel = ModelEntity(mesh: videoBoxMesh, materials: [videoBoxMaterial])
            videoBoxModel.position = SIMD3<Float>(0.3, 0.3, -0.6)
            anchor.addChild(videoBoxModel)
            player.play()
        }

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    func getBoxSizeForImage(image: UIImage, boxWidth: Float) -> SIMD3<Float> {
        let imageSize = image.size
        if imageSize.width > imageSize.height {
            let aspect = imageSize.width / imageSize.height
            return [Float(aspect) * boxWidth, boxWidth, boxWidth]
        } else {
            let aspect = imageSize.height / imageSize.width
            return [boxWidth, Float(aspect) * boxWidth, boxWidth]
        }
    }

    func getBoxSizeForVideo(url: URL, boxWidth: Float) -> SIMD3<Float> {
        let resolution = resolutionForVideo(url: url)
        let width = resolution.0!.width
        let height = resolution.0!.height

        guard resolution.1!.b == 0 else {
            if width > height {
                let aspect = Float(width / height)
                return [boxWidth, boxWidth, Float(aspect) * boxWidth]
            } else {
                let aspect = Float(height / width)
                return [boxWidth, Float(aspect) * boxWidth, boxWidth]
            }
        }

        if width > height {
            let aspect = Float(width / height)
            return [boxWidth, Float(aspect) * boxWidth, boxWidth]
        } else {
            let aspect = Float(height / width)
            return [boxWidth, 0.05, Float(aspect) * boxWidth]
        }
    }

    func resolutionForVideo(url: URL) -> (CGSize?, CGAffineTransform?) {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return (nil, nil) }
        let size = track.naturalSize.applying(track.preferredTransform)
        return (CGSize(width: abs(size.width), height: abs(size.height)), track.preferredTransform)
    }
}
