import UIKit
import ARKit
import Photos
import ARVideoKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, PopDelegate {
    
    var recorder:RecordAR?
    var turn : Bool = true
    
    let positionArray : [CGFloat] = [0.7, 1.2, 1.6, 2, 2.4, 2.8, 3.2, 3.4, 0.25]
    let radiusArray : [CGFloat]  = []
    let timechildArray : [TimeInterval] = [10, 11, 12, 13, 14, 15, 16, 17, 5]
    let timeArray : [TimeInterval] = [14, 18, 22, 26, 30, 34, 38, 42, 8]
    let textArray : [String] = ["1-Sao Thuỷ (Mercury)", "2-Sao Kim (Venus)", "3-Trái Đất (Earth)", "4-Sao Hoả (Mars)", "5-Sao Mộc (Jupiter)", "6-Sao Thổ (Saturn)", "7-Sao Thiên Vương (Uranus)", "8-Sao Hải Vương (Neptune)", "Mặt Trăng"]
    let textArrayC : [String] = [
        "Đặt tên: Sứ giả của các vị thần La Mã \n Đường kính: 4.878 km \n Quỹ đạo: 88 ngày Trái đất \n Ngày: 58,6 ngày Trái đất",
        "Đặt tên: Nữ thần tình yêu & sắc đẹp La Mã \n Đường kính: 12.104 km \n Quỹ đạo: 225 ngày Trái đất \n Ngày: 241 ngày Trái đất",
        "Đường kính: 12.760 km \n Quỹ đạo: 365,24 ngày \n Ngày: 23 giờ, 56 phút",
        "Đặt tên: Thần chiến tranh La Mã.\n Đường kính: 6.787 km. \n Quỹ đạo: 687 ngày Trái đất. \n Ngày: Chỉ hơn một ngày Trái đất (24 giờ, phút 37).",
        "Được đặt: Thần thoại Hy Lạp & La Mã.\n Đường kính: 139.822 km. \n Quỹ đạo: 11,9 năm Trái đất. \n Ngày: 9.8 giờ Trái đất.",
        "Đặt tên: Thần nông nghiệp La Mã. \n Đường kính: 120.500 km. \n Quỹ đạo: 29,5 năm Trái đất. \n Ngày: Khoảng 10,5 giờ Trái đất.",
        "Đặt tên: Vị thần bầu trời người Hy Lạp cổ. \n Đường kính: 51.120 km. \n Quỹ đạo: 84 năm Trái đất. \n Ngày: 18 giờ Trái đất.",
        "Đặt tên: Thần nước La Mã. \n Đường kính: 49.530 km. \n Quỹ đạo: 165 năm Trái đất. \n Ngày: 19 giờ Trái đất.", "Mặt Trăng"]
    let pipeRadiusValue : CGFloat = 0.001
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        runSystem()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(sender:)))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
        
        recorder = RecordAR(ARSceneKit: sceneView)
        
    }
        
    func tabNumber(number: Int) {
        if number == 1 {
            sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            let mercury = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "8k_mercury"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,0))
            let mercuryText = text(geometry: SCNText(string: textArray[0], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.5,0.07,0))
            let mercuryTextC = textChild(geometry: SCNText(string: textArrayC[0], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.6,-0.17,0))
            sceneView.scene.rootNode.addChildNode(mercury)
            sceneView.scene.rootNode.addChildNode(mercuryText)
            sceneView.scene.rootNode.addChildNode(mercuryTextC)
        }
        else if number == 2 {
            sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            let venus = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0, 0, 0))
            let venusText = text(geometry: SCNText(string: textArray[1], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.5,0.11,0))
            let venusTextC = textChild(geometry: SCNText(string: textArrayC[1], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.6,-0.11,0))
            
            sceneView.scene.rootNode.addChildNode(venus)
            sceneView.scene.rootNode.addChildNode(venusTextC)
            sceneView.scene.rootNode.addChildNode(venusText)
        }
        else if number == 3 {
            sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            let earth = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(0 ,0 , 0))
            
            let earthText = text(geometry: SCNText(string: textArray[2], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.5,0.11,0))
            let earthTextC = textChild(geometry: SCNText(string: textArrayC[2], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.6,-0.11,0))
            sceneView.scene.rootNode.addChildNode(earth)
            sceneView.scene.rootNode.addChildNode(earthText)
            sceneView.scene.rootNode.addChildNode(earthTextC)
        }
        else if number == 4 {
            sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            let mars = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "8k_mars"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,0))
            let marsText = text(geometry: SCNText(string: textArray[3], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.5,0.07,0))
            let marsTextC = textChild(geometry: SCNText(string: textArrayC[3], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.6,-0.17,0))
            sceneView.scene.rootNode.addChildNode(mars)
            sceneView.scene.rootNode.addChildNode(marsText)
            sceneView.scene.rootNode.addChildNode(marsTextC)
        }
        else if number == 5 {
            sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            let jupiter = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "8k_jupiter"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,0))
            let jupiterText = text(geometry: SCNText(string: textArray[4], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.5,0.36,0))
            let jupiterTextC = textChild(geometry: SCNText(string: textArrayC[4], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.6,0.16,0))
            sceneView.scene.rootNode.addChildNode(jupiter)
            sceneView.scene.rootNode.addChildNode(jupiterText)
            sceneView.scene.rootNode.addChildNode(jupiterTextC)
        }
        else if number == 6 {
            sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            let saturn = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "8k_saturn"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,0))
            let saturnText = text(geometry: SCNText(string: textArray[5], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.5,0.31,0))
            let saturnTextC = textChild(geometry: SCNText(string: textArrayC[5], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.6,0.11,0))
            sceneView.scene.rootNode.addChildNode(saturn)
            sceneView.scene.rootNode.addChildNode(saturnText)
            sceneView.scene.rootNode.addChildNode(saturnTextC)
        }
        else if number == 7 {
            sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            let uranus = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "2k_uranus"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,0))
            let uranusText = text(geometry: SCNText(string: textArray[6], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.5,0.26,0))
            let uranusTextC = textChild(geometry: SCNText(string: textArrayC[6], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.6,0.06,0))
            sceneView.scene.rootNode.addChildNode(uranus)
            sceneView.scene.rootNode.addChildNode(uranusText)
            sceneView.scene.rootNode.addChildNode(uranusTextC)
        }
        else if number == 8 {
            sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            let neptune = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "2k_neptune"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,0))
            let neptuneText = text(geometry: SCNText(string: textArray[7], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.5,0.26,0))
            let neptuneTextC = textChild(geometry: SCNText(string: textArrayC[7], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(0.6,0.06,0))
            sceneView.scene.rootNode.addChildNode(neptune)
            sceneView.scene.rootNode.addChildNode(neptuneText)
            sceneView.scene.rootNode.addChildNode(neptuneTextC)
        }
        else if number == 0 {
            sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            runSystem()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PopView" {
            let popVC = segue.destination
            popVC.popoverPresentationController?.delegate = self
            popVC.preferredContentSize = CGSize(width: 30, height: 300)
            let popDataVC = segue.destination as! PopViewControlereViewController
            popDataVC.delegateData = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.isPaused == false {
                node.isPaused = true
                if node.name == "text" {
                    node.isHidden = false
                }
            }
            else {
                node.isPaused = false
                if node.name == "text" {
                    node.isHidden = true
                }
            }
        }
    }
    @objc func handlePinch(sender: UIPinchGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let pinchLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(pinchLocation)
        
        if !hitTest.isEmpty {
            let results = hitTest.first!
            let node = results.node
            let pinchAction = SCNAction.scale(by: sender.scale, duration: 0)
            node.runAction(pinchAction)
            sender.scale = 1.0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //let configuration = ARWorldTrackingConfiguration()
        recorder?.prepare(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        recorder?.rest()
    }
    @IBAction func startRecording(_ sender: UIButton) {
        if turn == true {
        recorder?.record()
            turn = false
        }
        else {
        recorder?.stopAndExport()
        }
    }
    func runSystem() {
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let mercuryParent = SCNNode()
        let venusParent = SCNNode()
        let earthParent = SCNNode()
        let marsParent = SCNNode()
        let jupiterParent = SCNNode()
        let saturnParent = SCNNode()
        let uranusParent = SCNNode()
        let neptuneParent = SCNNode()
        let moonParent = SCNNode()
        
        //        sun.light = SCNLight()
        //        sun.light?.type = SCNLight.LightType.ambient
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
        sun.position = SCNVector3(0,0,-1)
        mercuryParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        earthParent.position = SCNVector3(0,0,-1)
        marsParent.position = SCNVector3(0,0,-1)
        jupiterParent.position = SCNVector3(0,0,-1)
        saturnParent.position = SCNVector3(0,0,-1)
        uranusParent.position = SCNVector3(0,0,-1)
        neptuneParent.position = SCNVector3(0,0,-1)
        moonParent.position = SCNVector3(0 ,0 , 0)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(mercuryParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(marsParent)
        self.sceneView.scene.rootNode.addChildNode(jupiterParent)
        self.sceneView.scene.rootNode.addChildNode(saturnParent)
        self.sceneView.scene.rootNode.addChildNode(uranusParent)
        self.sceneView.scene.rootNode.addChildNode(neptuneParent)
        
        let mercury = planet(geometry: SCNSphere(radius: 0.06), diffuse: #imageLiteral(resourceName: "8k_mercury"), specular: nil, emission: nil, normal: nil, position: SCNVector3(positionArray[0],0,0))
        let mercuryTorus =  torus(geometry: SCNTorus(ringRadius: positionArray[0], pipeRadius: pipeRadiusValue), diffuse: nil)
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(positionArray[1], 0, 0))
        let venusTorus =  torus(geometry: SCNTorus(ringRadius: positionArray[1], pipeRadius: pipeRadiusValue), diffuse: nil)
        let earth = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(positionArray[2] ,0 , 0))
        let earthTorus = torus(geometry: SCNTorus(ringRadius: positionArray[2], pipeRadius: pipeRadiusValue), diffuse: nil)
        let mars = planet(geometry: SCNSphere(radius: 0.06), diffuse: #imageLiteral(resourceName: "8k_mars"), specular: nil, emission: nil, normal: nil, position: SCNVector3(positionArray[3],0,0))
        let marsTorus =  torus(geometry: SCNTorus(ringRadius: positionArray[3], pipeRadius: pipeRadiusValue), diffuse: nil)
        let jupiter = planet(geometry: SCNSphere(radius: 0.35), diffuse: #imageLiteral(resourceName: "8k_jupiter"), specular: nil, emission: nil, normal: nil, position: SCNVector3(positionArray[4],0,0))
        let jupiterTorus =  torus(geometry: SCNTorus(ringRadius: positionArray[4], pipeRadius: pipeRadiusValue), diffuse: nil)
        let saturn = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "8k_saturn"), specular: nil, emission: nil, normal: nil, position: SCNVector3(positionArray[5],0,0))
        let saturnTorus =  torus(geometry: SCNTorus(ringRadius: positionArray[5], pipeRadius: pipeRadiusValue), diffuse: nil)
        let uranus = planet(geometry: SCNSphere(radius: 0.25), diffuse: #imageLiteral(resourceName: "2k_uranus"), specular: nil, emission: nil, normal: nil, position: SCNVector3(positionArray[6],0,0))
        let uranusTorus =  torus(geometry: SCNTorus(ringRadius: positionArray[6], pipeRadius: pipeRadiusValue), diffuse: nil)
        let neptune = planet(geometry: SCNSphere(radius: 0.25), diffuse: #imageLiteral(resourceName: "2k_neptune"), specular: nil, emission: nil, normal: nil, position: SCNVector3(positionArray[7],0,0))
        let neptuneTorus =  torus(geometry: SCNTorus(ringRadius: positionArray[7], pipeRadius: pipeRadiusValue), diffuse: nil)
        
        let moon = planet(geometry: SCNSphere(radius: 0.03), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(positionArray[8],0,0))
        let moonTorus =  torus(geometry: SCNTorus(ringRadius: positionArray[8], pipeRadius: pipeRadiusValue), diffuse: nil)
        
        let mercuryText = text(geometry: SCNText(string: textArray[0], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[0],0.07,0))
        let venusText = text(geometry: SCNText(string: textArray[1], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[1],0.11,0))
        let earthText = text(geometry: SCNText(string: textArray[2], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[2],0.11,0))
        let marsText = text(geometry: SCNText(string: textArray[3], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[3],0.07,0))
        let jupiterText = text(geometry: SCNText(string: textArray[4], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[4],0.36,0))
        let saturnText = text(geometry: SCNText(string: textArray[5], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[5],0.31,0))
        let uranusText = text(geometry: SCNText(string: textArray[6], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[6],0.26,0))
        let neptuneText = text(geometry: SCNText(string: textArray[7], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[7],0.26,0))
        
        let mercuryTextC = textChild(geometry: SCNText(string: textArrayC[0], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[0]+0.05,-0.17,0))
        let venusTextC = textChild(geometry: SCNText(string: textArrayC[1], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[1]+0.1,-0.11,0))
        let earthTextC = textChild(geometry: SCNText(string: textArrayC[2], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[2]+0.1,-0.11,0))
        let marsTextC = textChild(geometry: SCNText(string: textArrayC[3], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[3]+0.05,-0.17,0))
        let jupiterTextC = textChild(geometry: SCNText(string: textArrayC[4], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[4]+0.35,0.16,0))
        let saturnTextC = textChild(geometry: SCNText(string: textArrayC[5], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[5]+0.3,0.11,0))
        let uranusTextC = textChild(geometry: SCNText(string: textArrayC[6], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[6]+0.25,0.06,0))
        let neptuneTextC = textChild(geometry: SCNText(string: textArrayC[7], extrusionDepth: 1), diffuse: UIColor.red, position: SCNVector3(positionArray[7]+0.25,0.06,0))
        //MARK: ------------------------------------------------ Rotation-------------------------------------------------------------------------
        
        let sunAction = Rotation(time: 8)
        
        mercury.runAction(Rotation(time: timechildArray[0]))
        earth.runAction(Rotation(time: timechildArray[2]))
        venus.runAction(Rotation(time: timechildArray[1]))
        mars.runAction(Rotation(time: timechildArray[3]))
        jupiter.runAction(Rotation(time: timechildArray[4]))
        saturn.runAction(Rotation(time: timechildArray[5]))
        uranus.runAction(Rotation(time: timechildArray[6]))
        neptune.runAction(Rotation(time: timechildArray[7]))
        moon.runAction(Rotation(time: timechildArray[8]))
        
        mercuryParent.runAction(Rotation(time: timeArray[0]))
        earthParent.runAction(Rotation(time: timeArray[2]))
        venusParent.runAction(Rotation(time: timeArray[1]))
        marsParent.runAction(Rotation(time: timeArray[3]))
        jupiterParent.runAction(Rotation(time: timeArray[4]))
        saturnParent.runAction(Rotation(time: timeArray[5]))
        uranusParent.runAction(Rotation(time: timeArray[6]))
        neptuneParent.runAction(Rotation(time: timeArray[7]))
        moonParent.runAction(Rotation(time: timeArray[8]))
        
        //MARK: - -----------------------------------------------Add childNode ---------------------------------------------------------
        sun.runAction(sunAction)
        sun.addChildNode(earthTorus)
        sun.addChildNode(venusTorus)
        
        // sun.isHidden = true
        mercuryParent.addChildNode(mercury)
        mercuryParent.addChildNode(mercuryTorus)
        mercuryParent.addChildNode(mercuryText)
        earthParent.addChildNode(earth)
        earthParent.addChildNode(earthText)
        venusParent.addChildNode(venus)
        venusParent.addChildNode(venusTorus)
        venusParent.addChildNode(venusText)
        marsParent.addChildNode(mars)
        marsParent.addChildNode(marsTorus)
        marsParent.addChildNode(marsText)
        jupiterParent.addChildNode(jupiter)
        jupiterParent.addChildNode(jupiterTorus)
        jupiterParent.addChildNode(jupiterText)
        saturnParent.addChildNode(saturn)
        saturnParent.addChildNode(saturnTorus)
        saturnParent.addChildNode(saturnText)
        uranusParent.addChildNode(uranus)
        uranusParent.addChildNode(uranusTorus)
        uranusParent.addChildNode(uranusText)
        neptuneParent.addChildNode(neptune)
        neptuneParent.addChildNode(neptuneTorus)
        neptuneParent.addChildNode(neptuneText)
        earth.addChildNode(moonParent)
        moonParent.addChildNode(moonTorus)
        // moonParent.addChildNode(moonText)
        moonParent.addChildNode(moon)
        
        mercuryParent.addChildNode(mercuryTextC)
        earthParent.addChildNode(earthTextC)
        venusParent.addChildNode(venusTextC)
        marsParent.addChildNode(marsTextC)
        jupiterParent.addChildNode(jupiterTextC)
        saturnParent.addChildNode(saturnTextC)
        uranusParent.addChildNode(uranusTextC)
        neptuneParent.addChildNode(neptuneTextC)
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage?, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
        
    }
    
    func torus(geometry: SCNGeometry, diffuse: UIColor?) -> SCNNode {
        let torus = SCNNode(geometry: geometry)
        torus.geometry?.firstMaterial?.diffuse.contents = diffuse
        torus.position = SCNVector3(0,0,0)
        return torus
        
    }
    
    func text(geometry: SCNGeometry, diffuse: UIColor?, position: SCNVector3) -> SCNNode {
        let text = SCNNode(geometry: geometry)
        text.geometry?.firstMaterial?.diffuse.contents = diffuse
        text.position = position
        text.scale = SCNVector3(0.01, 0.01, 0.01)
        text.name = "text"
        text.isHidden = true
        return text
    }
    
    func textChild(geometry: SCNGeometry, diffuse: UIColor?, position: SCNVector3) -> SCNNode {
        let text = SCNNode(geometry: geometry)
        text.geometry?.firstMaterial?.diffuse.contents = diffuse
        text.position = position
        text.scale = SCNVector3(0.004, 0.004, 0.004)
        text.name = "text"
        text.isHidden = true
        return text
    }
    
    
    func Rotation(time: TimeInterval) -> SCNAction {
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(-360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(Rotation)
        return foreverRotation
    }
    
    
    
    
}
extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}


