//
//  RampPickerVC.swift
//  sceneone
//
//  Created by Earl Ledesma on 13/05/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit
import SceneKit //3D Models

class RampPickerVC: UIViewController {

    var sceneView: SCNView! //This displays the 3D models on the screen
    var size: CGSize!
    
    
    init(size: CGSize) { // custom initializer, so when the ramplacer shows the popover, we can pass in a size
        super.init(nibName: nil, bundle: nil)
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.insertSubview(sceneView, at: 0)
        
        let scene = SCNScene(named: "art.scnassets/ramps.scn")! // This loads the ramps.scn scene for us, for unwrap it to make sure it's there because it has to exist in the app
        sceneView.scene = scene // to show it in our scene
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene.rootNode.camera = camera
        
        let obj = SCNScene(named: "art.scnassets/pipe.dae")// We created a scene, pipe scene
        let node = obj?.rootNode.childNode(withName: "pipe", recursively: true)! //Whenever we move the .dae scene we move ALL of it, e.g. Background/objects etc. every scene has a rootnode, then we look for a childnode named "pipe" the item we referenced.
        node?.scale = SCNVector3Make(0.0022, 0.0022, 0.0022)
        node?.position = SCNVector3Make(-0.95, 0.5, -1)
        
        scene.rootNode.addChildNode(node!) // we take that node and add it to our scene
        preferredContentSize = size
        
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
