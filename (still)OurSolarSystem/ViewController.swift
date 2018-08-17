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
        self.greyEarthAndMoon()
        //self.colorEarthAndMoon()
        
    }
    
    
    
    func greyEarthAndMoon() {
        let earth = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "Earth daylight grey"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: nil, normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(0, 0, -1.2))
        let earthClouds = planet(geometry: SCNSphere(radius: 0.306), diffuse: #imageLiteral(resourceName: "Earth Clouds grey"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, 0))
        let MoonAndEarthBarycentre = planet(geometry: SCNSphere(radius: 0.004), diffuse: nil, specular: nil, emission: nil, normal: nil, position: SCNVector3(0.22, 0, 0))
        let moon = planet(geometry: SCNSphere(radius: 0.0818), diffuse: #imageLiteral(resourceName: "Moon grey"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1.8, 0, 0))
        
        let rotateEarthAction = rotation(time: 60, y: CGFloat(360.degreesToRadians))
        let rotateCloudsAction = rotation(time: 300, y: CGFloat(-360.degreesToRadians))
        let barycentreRotateAction = rotation(time: 163, y: CGFloat(360.degreesToRadians))
        
        earth.runAction(rotateEarthAction)
        earthClouds.runAction(rotateCloudsAction)
        MoonAndEarthBarycentre.runAction(barycentreRotateAction)
        
        self.sceneView.scene.rootNode.addChildNode(earth)
        earth.addChildNode(earthClouds)
        earth.addChildNode(MoonAndEarthBarycentre)
        MoonAndEarthBarycentre.addChildNode(moon)
    }
    
    
    func colorEarthAndMoon() {
        let earthInColor = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "Earth daylight color"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: nil, normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(0, 0, -1.2))
        let earthInColorClouds = planet(geometry: SCNSphere(radius: 0.306), diffuse: #imageLiteral(resourceName: "Earth Clouds color"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, 0))
        let MoonAndEarthBarycentre = planet(geometry: SCNSphere(radius: 0.004), diffuse: nil, specular: nil, emission: nil, normal: nil, position: SCNVector3(0.22, 0, 0))
        let moon = planet(geometry: SCNSphere(radius: 0.0818), diffuse: #imageLiteral(resourceName: "Moon color"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1.8, 0, 0))
        
        let rotateEarthAction = rotation(time: 60, y: CGFloat(360.degreesToRadians))
        let rotateCloudsAction = rotation(time: 300, y: CGFloat(-360.degreesToRadians))
        let barycentreRotateAction = rotation(time: 163, y: CGFloat(360.degreesToRadians))
        
        earthInColor.runAction(rotateEarthAction)
        earthInColorClouds.runAction(rotateCloudsAction)
        MoonAndEarthBarycentre.runAction(barycentreRotateAction)
        
        self.sceneView.scene.rootNode.addChildNode(earthInColor)
        earthInColor.addChildNode(earthInColorClouds)
        earthInColor.addChildNode(MoonAndEarthBarycentre)
        MoonAndEarthBarycentre.addChildNode(moon)
    }
    
    
    func rotation(time: TimeInterval, y: CGFloat) -> SCNAction {
        let rotateAction = SCNAction.rotateBy(x: 0, y: y, z: 0, duration: time)
        let foreverAction = SCNAction.repeatForever(rotateAction)
        return foreverAction
    }
    
    
    func planet(geometry: SCNGeometry, diffuse: UIImage?, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
    
    
    func restartTheSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    
    @IBAction func reset(_ sender: Any) {
        self.restartTheSession()
    }

}



extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

