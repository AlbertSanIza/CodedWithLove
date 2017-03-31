import SpriteKit
public class InstructionsSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        if let sksStars: SKSpriteNode = childNode(withName: "sksStars") as! SKSpriteNode? {
            sksStars.texture = SKTexture(imageNamed: "sprites/background/starsLayer2.png")
        }
        if let sksW: SKSpriteNode = childNode(withName: "sksW") as! SKSpriteNode?, let sksA: SKSpriteNode = childNode(withName: "sksA") as! SKSpriteNode?, let sksS: SKSpriteNode = childNode(withName: "sksS") as! SKSpriteNode?, let sksD: SKSpriteNode = childNode(withName: "sksD") as! SKSpriteNode?, let sksO: SKSpriteNode = childNode(withName: "sksO") as! SKSpriteNode?, let sksSpace: SKSpriteNode = childNode(withName: "sksSpace") as! SKSpriteNode? {
            sksW.texture = SKTexture(imageNamed: "sprites/keyboard/computerKeyW.png")
            sksA.texture = SKTexture(imageNamed: "sprites/keyboard/computerKeyA.png")
            sksS.texture = SKTexture(imageNamed: "sprites/keyboard/computerKeyS.png")
            sksD.texture = SKTexture(imageNamed: "sprites/keyboard/computerKeyD.png")
            sksO.texture = SKTexture(imageNamed: "sprites/keyboard/computerKeyO.png")
            sksSpace.texture = SKTexture(imageNamed: "sprites/keyboard/computerKeySpaceBarpng")
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
