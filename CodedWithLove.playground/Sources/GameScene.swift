import SpriteKit
public class GameSceneFile: SKScene {
    var thePlayer: SKSpriteNode = SKSpriteNode()
    var wKey: Bool = false
    var sKey: Bool = false
    var aKey: Bool = false
    var dKey: Bool = false
    var spaceKey: Bool = false
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        if let sksBackground: SKSpriteNode = childNode(withName: "sksBackground") as! SKSpriteNode? {
            sksBackground.texture = SKTexture(imageNamed: "sprites/background/backgrounds" + String(arc4random_uniform(2)) + ".png")
            if let sksClouds: SKSpriteNode = childNode(withName: "sksClouds") as! SKSpriteNode? {
                sksClouds.texture = SKTexture(imageNamed: "sprites/background/clouds" + String(arc4random_uniform(3)) + String(arc4random_uniform(2)) + ".png")
                if let sksStars: SKSpriteNode = childNode(withName: "sksStars") as! SKSpriteNode? {
                    sksStars.texture = SKTexture(imageNamed: "sprites/background/starsLayer" + String(arc4random_uniform(2)) + ".png")
                    if let sksPlanets1: SKSpriteNode = childNode(withName: "sksPlanets1") as! SKSpriteNode? {
                        sksPlanets1.texture = SKTexture(imageNamed: "sprites/art/planet" + String(arc4random_uniform(6)) + ".png")
                        if let sksPlanets2: SKSpriteNode = childNode(withName: "sksPlanets2") as! SKSpriteNode? {
                            sksPlanets2.texture = SKTexture(imageNamed: "sprites/art/planet" + String(arc4random_uniform(6)) + ".png")
                        }
                    }
                }
            }
        }
        if let sknPlayer: SKSpriteNode = childNode(withName: "sksPlayer") as! SKSpriteNode? {
            thePlayer = sknPlayer
            thePlayer.texture = SKTexture(imageNamed: "sprites/art/player.png")
            if let sksJet: SKSpriteNode = thePlayer.childNode(withName: "sksJet") as! SKSpriteNode? {
                sksJet.texture = SKTexture(imageNamed: "sprites/art/jet.png")
            }
            if let sksJetLeft: SKSpriteNode = thePlayer.childNode(withName: "sksJetLeft") as! SKSpriteNode? {
                sksJetLeft.texture = SKTexture(imageNamed: "sprites/art/jet.png")
            }
            if let sksJetRight: SKSpriteNode = thePlayer.childNode(withName: "sksJetRight") as! SKSpriteNode? {
                sksJetRight.texture = SKTexture(imageNamed: "sprites/art/jet.png")
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
            thePlayer.run(SKAction.moveBy(x: (spaceKey ? 8 : 4) * cos(thePlayer.zRotation + degreesToRadians(degrees: 90)), y: (spaceKey ? 8 : 4) * sin(thePlayer.zRotation + degreesToRadians(degrees: 90)), duration: 0.5))
        }
        if sKey {
            thePlayer.run(SKAction.moveBy(x: -2 * cos(thePlayer.zRotation + degreesToRadians(degrees: 90)), y: -2 * sin(thePlayer.zRotation + degreesToRadians(degrees: 90)), duration: 0.3))
        }
        if aKey {
            thePlayer.zRotation += degreesToRadians(degrees: 4)
        }
        if dKey {
            thePlayer.zRotation -= degreesToRadians(degrees: 4)
        }
        if thePlayer.position.y > 400 {
            thePlayer.position.y = -398
        } else if thePlayer.position.y < -400 {
            thePlayer.position.y = 398
        }
        if thePlayer.position.x > 528 {
            thePlayer.position.x = -526
        } else if thePlayer.position.x < -528 {
            thePlayer.position.x = 526
        }
    }
    override public func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 13:
            if !wKey {
                wKey = true
                thePlayer.childNode(withName: "sksJet")?.run(SKAction.fadeAlpha(to: 0.7, duration: 0.4), withKey: "sksJet")
            }
        case 1:
            if !sKey {
                sKey = true
            }
        case 0:
            if !aKey {
                aKey = true
                if !sKey {
                    thePlayer.childNode(withName: "sksJetRight")?.run(SKAction.fadeAlpha(to: 0.7, duration: 0.4), withKey: "sksJetRight")
                }
            }
        case 2:
            if !dKey {
                dKey = true
                if !sKey {
                    thePlayer.childNode(withName: "sksJetLeft")?.run(SKAction.fadeAlpha(to: 0.7, duration: 0.4), withKey: "sksJetLeft")
                }
            }
        case 49:
            if !spaceKey {
                spaceKey = true
            }
        default: break
        }
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 13:
            wKey = false
            thePlayer.childNode(withName: "sksJet")?.run(SKAction.fadeOut(withDuration: 0.2), withKey: "sksJet")
        case 1:
            sKey = false
        case 0:
            aKey = false
            thePlayer.childNode(withName: "sksJetRight")?.run(SKAction.fadeOut(withDuration: 0.2), withKey: "sksJetRight")
        case 2:
            dKey = false
            thePlayer.childNode(withName: "sksJetLeft")?.run(SKAction.fadeOut(withDuration: 0.2), withKey: "sksJetLeft")
        case 49:
            spaceKey = false
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
        view?.presentScene(toGoScene, transition: SKTransition.fade(withDuration: 2.0))
    }
    func radiansToDegrees(radians: CGFloat) -> CGFloat {
        return radians * 180 / CGFloat(M_PI)
    }
    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat(M_PI) / 180
    }
}
