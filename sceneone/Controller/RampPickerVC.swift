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
    weak var rampPlacerVC: RampPlacerVC! // Weak reference to prevent uneeded retain cycle
    
    
    
    
    init(withSize size: CGSize)
    {
        super.init(nibName: nil, bundle: nil)
        
        self.size = size
    }
//    init(size: CGSize) { // custom initializer, so when the ramplacer shows the popover, we can pass in a size
//        super.init(nibName: nil, bundle: nil)
//        self.size = size
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.frame = CGRect(origin: CGPoint.zero, size: self.size)
        self.sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        self.view.insertSubview(self.sceneView, at: 0)
        self.preferredContentSize = self.size
        self.view.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.layer.borderWidth = 3.0
        
        
        let scene = SCNScene(named: "\(SCENE_ASSETS_DIRECTORY)ramps.scn")!
        self.sceneView.scene = scene
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene.rootNode.camera = camera
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.sceneView.addGestureRecognizer(tapGesture)
        
        
        let pipe = RampUtility.getPipe(withScale: 0.0022, andPosition: SCNVector3(-1, 0.7, -1))
        RampUtility.startRotation(node: pipe)
        scene.rootNode.addChildNode(pipe)
        
        let pyramid = RampUtility.getPyramid(withScale: 0.0058, andPosition: SCNVector3(-1, -0.45, -1))
        RampUtility.startRotation(node: pyramid)
        scene.rootNode.addChildNode(pyramid)
        
        let quarter = RampUtility.getQuarter(withScale: 0.0058, andPosition: SCNVector3(-1, -2.2, -1))
        RampUtility.startRotation(node: quarter)
        scene.rootNode.addChildNode(quarter)
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.frame = CGRect(origin: CGPoint.zero, size: size)
//        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//        view.insertSubview(sceneView, at: 0)
//
//        preferredContentSize = size
//
//        let scene = SCNScene(named: "art.scnassets/ramps.scn")! // This loads the ramps.scn scene for us, for unwrap it to make sure it's there because it has to exist in the app
//        sceneView.scene = scene // to show it in our scene
//
//        let camera = SCNCamera()
//        camera.usesOrthographicProjection = true
//        scene.rootNode.camera = camera
//
//        var obj = SCNScene(named: "art.scnassets/pipe.scn")// We created a scene, pipe scene
//        var node = obj?.rootNode.childNode(withName: "pipe", recursively: true)! //Whenever we move the .dae scene we move ALL of it, e.g. Background/objects etc. every scene has a rootnode, then we look for a childnode named "pipe" the item we referenced.
//        node?.scale = SCNVector3Make(0.0022, 0.0022, 0.0022)
//        node?.position = SCNVector3Make(-0.95, 0.5, -1)
//
//        scene.rootNode.addChildNode(node!) // we take that node and add it to our scene
//
//
//        obj = SCNScene(named: "art.ascnassets/pyramid.scn")
//        node = obj?.rootNode.childNode(withName: "pyramid", recursively: true)!
//        node?.scale = SCNVector3Make(0.0032, 0.0032, 0.0032)
//        node?.position = SCNVector3Make(-0.95, -0.9, -1)
//        scene.rootNode.addChildNode(node!)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc
    func handleTap(_ gestureRecognizer: UIGestureRecognizer)
    {
        let p = gestureRecognizer.location(in: self.sceneView)
        let hitResults = sceneView.hitTest(p, options: [:])     // Ray collison test with stuff in the scene
        
        if hitResults.count > 0
        {
            let node = hitResults[0].node
            self.rampPlacerVC.onRampSelected(node.name!)
            dismiss(animated: true, completion: nil)
        }
    }
//        let p = gestureRecognizer.location(in: self.sceneView)
//        let hitResults = sceneView.hitTest(p, options: [:])     // Ray collison test with stuff in the scene
//
//        if hitResults.count > 0
//        {
//            let node = hitResults[0].node
//            self.rampPlacerVC.onRampSelected(node.name!)
//            dismiss(animated: true, completion: nil)
//        }
    }

