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
        let mercuryParent = SCNNode()
        let venusParent = SCNNode()
        let earthParent = SCNNode()
        let marsParent = SCNNode()
        let jupiterParent = SCNNode()
        let saturnParent = SCNNode()
        
        mercuryParent.position = solarSystemCenter()
        venusParent.position = solarSystemCenter()
        earthParent.position = solarSystemCenter()
        marsParent.position = solarSystemCenter()
        jupiterParent.position = solarSystemCenter()
        saturnParent.position = solarSystemCenter()
        
        let sun = planet(geometry: SCNSphere(radius: 0.35), diffuse: #imageLiteral(resourceName: "Sun Grey 1 layer"), specular: nil, emission: nil, normal: nil, position: solarSystemCenter())
        let sun3dEffect = planet(geometry: SCNSphere(radius: 0.355), diffuse: #imageLiteral(resourceName: "Sun Grey 2 layer"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, 0))
        let mercury = planet(geometry: SCNSphere(radius: 0.023), diffuse: #imageLiteral(resourceName: "Mercury Color"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.45))
        let venus = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Venus Grey"), specular: nil, emission: #imageLiteral(resourceName: "Venus Emission"), normal: nil, position: SCNVector3(0, 0, -0.6))
        let earth = planet(geometry: SCNSphere(radius: 0.08), diffuse: #imageLiteral(resourceName: "Earth daylight grey"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: nil, normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(0, 0, -1.2))
        let earthClouds = planet(geometry: SCNSphere(radius: 0.083), diffuse: #imageLiteral(resourceName: "Earth Clouds grey"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, 0))
        let MoonAndEarthBarycentre = planet(geometry: SCNSphere(radius: 0.002), diffuse: nil, specular: nil, emission: nil, normal: nil, position: SCNVector3(0.07, 0, 0))
        let moon = planet(geometry: SCNSphere(radius: 0.023), diffuse: #imageLiteral(resourceName: "Moon grey"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.2, 0, 0))
        let mars = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Mars Greish"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -2))
        let jupiter = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Jupiter Grey"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -2.3))
        let saturn = planet(geometry: SCNSphere(radius: 0.17), diffuse: #imageLiteral(resourceName: "Saturn Grey"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -3.2))
        let saturnRings = planet(geometry: SCNCylinder(radius: 0.3, height: 0.001), diffuse: #imageLiteral(resourceName: "Saturn Rings"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, 0))
        
        let rotateSunAction = rotation(time: 300, y: CGFloat(360.degreesToRadians))
        let rotateMercuryParent = rotation(time: 30, y: CGFloat(360.degreesToRadians))
        let rotateMercuryAction = rotation(time: 300, y: CGFloat(360.degreesToRadians))
        let rotateVenusParent = rotation(time: 45, y: CGFloat(360.degreesToRadians))
        let rotateVenusAction = rotation(time: 200, y: CGFloat(360.degreesToRadians))
        let rotateEarthParent = rotation(time: 60, y: CGFloat(360.degreesToRadians))
        let rotateEarthAction = rotation(time: 60, y: CGFloat(360.degreesToRadians))
        let rotateCloudsAction = rotation(time: 300, y: CGFloat(-360.degreesToRadians))
        let barycentreRotateAction = rotation(time: 163, y: CGFloat(360.degreesToRadians))
        let rotateMarsParent = rotation(time: 115, y: CGFloat(360.degreesToRadians))
        let rotateMarsAction = rotation(time: 70, y: CGFloat(360.degreesToRadians))
        let rotateJupiterParent = rotation(time: 500, y: CGFloat(360.degreesToRadians))
        let rotateJupiterAction = rotation(time: 26, y: CGFloat(360.degreesToRadians))
        let rotateSaturnParent = rotation(time: 800, y: CGFloat(360.degreesToRadians))
        let rotateSaturnAction = rotation(time: 29, y: CGFloat(360.degreesToRadians))
        
        sun.runAction(rotateSunAction)
        mercuryParent.runAction(rotateMercuryParent)
        mercury.runAction(rotateMercuryAction)
        venusParent.runAction(rotateVenusParent)
        venus.runAction(rotateVenusAction)
        earthParent.runAction(rotateEarthParent)
        earth.runAction(rotateEarthAction)
        earthClouds.runAction(rotateCloudsAction)
        MoonAndEarthBarycentre.runAction(barycentreRotateAction)
        marsParent.runAction(rotateMarsParent)
        mars.runAction(rotateMarsAction)
        jupiterParent.runAction(rotateJupiterParent)
        jupiter.runAction(rotateJupiterAction)
        saturnParent.runAction(rotateSaturnParent)
        saturn.runAction(rotateSaturnAction)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(mercuryParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(marsParent)
        self.sceneView.scene.rootNode.addChildNode(jupiterParent)
        self.sceneView.scene.rootNode.addChildNode(saturnParent)
        
        sun.addChildNode(sun3dEffect)
        mercuryParent.addChildNode(mercury)
        venusParent.addChildNode(venus)
        earthParent.addChildNode(earth)
        earth.addChildNode(earthClouds)
        earth.addChildNode(MoonAndEarthBarycentre)
        MoonAndEarthBarycentre.addChildNode(moon)
        marsParent.addChildNode(mars)
        jupiterParent.addChildNode(jupiter)
        saturnParent.addChildNode(saturn)
        saturn.addChildNode(saturnRings)
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
    
    func solarSystemCenter() -> SCNVector3 {
        let solarSystemCenter = SCNVector3(0, -0.5, -2)
        return solarSystemCenter
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

