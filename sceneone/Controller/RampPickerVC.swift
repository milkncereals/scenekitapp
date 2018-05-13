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
    
    
    init(withSize size: CGSize) { // custom initializer, so when the ramplacer shows the popover, we can pass in a size
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
