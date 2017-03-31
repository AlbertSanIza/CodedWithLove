import SpriteKit
public class InstructionsSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        if let sksStars: SKSpriteNode = childNode(withName: "sksStars") as! SKSpriteNode? {
            sksStars.texture = SKTexture(imageNamed: "sprites/background/starsLayer2.png")
        }
        if let nodeMenu: SKNode = childNode(withName: "nodeMenu") {
            if let sksW: SKSpriteNode = nodeMenu.childNode(withName: "sksW") as! SKSpriteNode? {
                sksW.texture = SKTexture(imageNamed: "sprites/keyboard/computerKeyW.png")
            }
            if let sksA: SKSpriteNode = nodeMenu.childNode(withName: "sksA") as! SKSpriteNode? {
                sksA.texture = SKTexture(imageNamed: "sprites/keyboard/computerKeyA.png")
            }
            if let sksS: SKSpriteNode = nodeMenu.childNode(withName: "sksS") as! SKSpriteNode? {
                sksS.texture = SKTexture(imageNamed: "sprites/keyboard/computerKeyS.png")
            }
            if let sksD: SKSpriteNode = nodeMenu.childNode(withName: "sksD") as! SKSpriteNode? {
                sksD.texture = SKTexture(imageNamed: "sprites/keyboard/computerKeyD.png")
            }
            if let sksO: SKSpriteNode = nodeMenu.childNode(withName: "sksO") as! SKSpriteNode? {
                sksO.texture = SKTexture(imageNamed: "sprites/keyboard/computerKeyO.png")
            }
            if let sksSpace: SKSpriteNode = nodeMenu.childNode(withName: "sksSpace") as! SKSpriteNode? {
                sksSpace.texture = SKTexture(imageNamed: "sprites/keyboard/computerKeySpaceBar.png")
            }
        }
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 53, 11:
            run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
            goToScene()
        default: break
        }
    }
    override public func mouseDown(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        if let touchedNode = nodes(at: mousePoint).first {
            switch touchedNode.name {
            case "txtBack"?:
                run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
                touchedNode.run(SKAction.fadeOut(withDuration: 0.5)) {
                    self.goToScene()
                }
            default: break
            }
        }
    }
    func goToScene() {
        let mainMenuScene: SKScene = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene.sks")!
        mainMenuScene.scaleMode = .aspectFit
        view?.presentScene(mainMenuScene, transition: SKTransition.fade(withDuration: 2.0))
    }
}
