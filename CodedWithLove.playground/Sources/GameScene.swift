import SpriteKit
public class GameSceneFile: SKScene {
    var thePlayer: SKNode = SKNode()
    var wKey: Bool = false
    var sKey: Bool = false
    var aKey: Bool = false
    var dKey: Bool = false
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        if let sceneBackground: SKSpriteNode = childNode(withName: "sksBackground") as! SKSpriteNode? {
            sceneBackground.texture = SKTexture(imageNamed: "sprites/background/backgrounds" + String(arc4random_uniform(2)) + ".png")
            if let sceneClouds: SKSpriteNode = childNode(withName: "sksClouds") as! SKSpriteNode? {
                sceneClouds.texture = SKTexture(imageNamed: "sprites/background/clouds" + String(arc4random_uniform(3)) + String(arc4random_uniform(2)) + ".png")
                if let sceneStars: SKSpriteNode = childNode(withName: "sksStars") as! SKSpriteNode? {
                    sceneStars.texture = SKTexture(imageNamed: "sprites/background/starsLayer" + String(arc4random_uniform(2)) + ".png")
                    if let scenePlanets1: SKSpriteNode = childNode(withName: "sksPlanets1") as! SKSpriteNode? {
                        scenePlanets1.texture = SKTexture(imageNamed: "sprites/art/planet" + String(arc4random_uniform(6)) + ".png")
                        if let scenePlanets2: SKSpriteNode = childNode(withName: "sksPlanets2") as! SKSpriteNode? {
                            scenePlanets2.texture = SKTexture(imageNamed: "sprites/art/planet" + String(arc4random_uniform(6)) + ".png")
                        }
                    }
                }
            }
        }
        if let sknPlayer: SKNode = childNode(withName: "sknPlayer") {
            thePlayer = sknPlayer
            if let sksPlayer: SKSpriteNode = thePlayer.childNode(withName: "sksPlayer") as! SKSpriteNode? {
                sksPlayer.texture = SKTexture(imageNamed: "sprites/art/player.png")
            }
            if let sksJet: SKSpriteNode = thePlayer.childNode(withName: "sksJet") as! SKSpriteNode? {
                sksJet.texture = SKTexture(imageNamed: "sprites/art/jet.png")
            }
        }
    }
    override public func didMove(to view: SKView) {
        enumerateChildNodes(withName: "sksPlanets*") {
            (node, stop) in
            node.position = self.convertPoint(fromView: CGPoint(x: CGFloat(arc4random_uniform(600)), y: CGFloat(arc4random_uniform(450))))
        }
    }
    override public func update(_ currentTime: TimeInterval) {
        if wKey {
            thePlayer.position.x += 5 * cos(thePlayer.zRotation + degreesToRadians(degrees: 90))
            thePlayer.position.y += 5 * sin(thePlayer.zRotation + degreesToRadians(degrees: 90))
        }
        if sKey {
            thePlayer.position.x -= 2 * cos(thePlayer.zRotation + degreesToRadians(degrees: 90))
            thePlayer.position.y -= 2 * sin(thePlayer.zRotation + degreesToRadians(degrees: 90))
        }
        if aKey {
            thePlayer.zRotation += degreesToRadians(degrees: 4)
            if radiansToDegrees(radians: thePlayer.zRotation) > 359 {
                thePlayer.zRotation = degreesToRadians(degrees: 0)
            }
        }
        if dKey {
            thePlayer.zRotation -= degreesToRadians(degrees: 4)
            if radiansToDegrees(radians: thePlayer.zRotation) < 0 {
                thePlayer.zRotation = degreesToRadians(degrees: 359)
            }
        }
        if thePlayer.position.y > 390 {
            thePlayer.position.y = -385
        } else if thePlayer.position.y < -390 {
            thePlayer.position.y = 385
        }
        if thePlayer.position.x > 518 {
            thePlayer.position.x = -513
        } else if thePlayer.position.x < -518 {
            thePlayer.position.x = 513
        }
    }
    override public func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 13:
            wKey = true
        case 1:
            sKey = true
        case 0:
            aKey = true
        case 2:
            dKey = true
        default: break
        }
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 13:
            wKey = false
        case 1:
            sKey = false
        case 0:
            aKey = false
        case 2:
            dKey = false
        default: break
        }
    }
    func goToScene(withName: String) {
        let toGoScene: SKScene
        switch withName {
        default:
            toGoScene = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene.sks")!
        }
        toGoScene.scaleMode = .aspectFit
        view?.presentScene(toGoScene, transition: SKTransition.crossFade(withDuration: 2.0))
    }
    func radiansToDegrees(radians: CGFloat) -> CGFloat {
        return radians * 180 / CGFloat(M_PI)
    }
    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat(M_PI) / 180
    }
}
