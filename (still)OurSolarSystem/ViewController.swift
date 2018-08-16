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
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    
    @IBAction func add(_ sender: Any) {
        self.greyEarth()
        
    }
    
    
    
    func greyEarth() {
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: 0.2)
        earth.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Earth daylight grey")
        earth.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "Earth Specular")
        earth.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "Earth Normal")
        earth.position = SCNVector3(0, 0, -1)
        self.sceneView.scene.rootNode.addChildNode(earth)
        
        let rotateEarthAction = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 32)
        let foreverRotateEarth = SCNAction.repeatForever(rotateEarthAction)
        earth.runAction(foreverRotateEarth)
        
        let earthClouds = SCNNode()
        earthClouds.geometry=SCNSphere(radius: 0.206)
        earthClouds.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Earth Clouds")
        earthClouds.position = SCNVector3(0, 0, 0)
        
        let rotateCloudsAction = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 96)
        
        let foreverRotateClouds = SCNAction.repeatForever(rotateCloudsAction)
        earthClouds.runAction(foreverRotateClouds)
        
        earth.addChildNode(earthClouds)
    }
    

    @IBAction func reset(_ sender: Any) {
        self.restartTheSession()
    }
    
    
    func restartTheSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

}



extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

