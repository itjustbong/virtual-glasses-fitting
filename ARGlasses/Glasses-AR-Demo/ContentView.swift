//
//  ContentView.swift
//  Glasses-AR-Demo
//
//  Created by Pete Murray on 12/10/2022.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {

	@State private var isPresented: Bool = false

    var body: some View {
        VStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
                .alert("Face Tracking Unavailable", isPresented: $isPresented) {
                    Button {
                        isPresented = false
                    } label: {
                        Text("Okay")
                    }
                } message: {
                    Text("Face tracking requires an iPhone X or later.")
                }
                .onAppear {
                    if !ARFaceTrackingConfiguration.isSupported {
                        isPresented = true
                    }
                }
            Spacer()
            HStack {
                Text("")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
            .frame(
                  maxWidth: .infinity,
                  minHeight: 200
            )
            .background(Color.white)
        }

	}
}

struct ARViewContainer: UIViewRepresentable {
	func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Load the "Face" scene from the "Glasses" Reality File
		if let faceScene = try? PartyGlasses.loadFace() {
			arView.scene.anchors.append(faceScene)
		}

		let arConfig = ARFaceTrackingConfiguration()
		arView.session.run(arConfig)

        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
