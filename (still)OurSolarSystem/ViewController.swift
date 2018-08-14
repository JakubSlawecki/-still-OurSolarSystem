//
//  ViewController.swift
//  (still)OurSolarSystem
//
//  Created by Jakub Slawecki on 14.08.2018.
//  Copyright © 2018 Jakub Slawecki. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    let configuration = ARWorldTrackingConfiguration()
    
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)

       
    }

   

}

