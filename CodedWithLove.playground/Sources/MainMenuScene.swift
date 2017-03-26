import SpriteKit
public class MainMenuSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        if let sceneStars: SKSpriteNode = childNode(withName: "sksStars") as! SKSpriteNode? {
            sceneStars.texture = SKTexture(imageNamed: "sprites/background/starsLayer2.png")
        }
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 1, 36:
            run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
            goToScene(withName: "txtStart")
        case 34:
            run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
            goToScene(withName: "txtInstructions")
        case 0:
            run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
            goToScene(withName: "txtAbout")
        case 53, 11:
            run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
            goToScene(withName: "txtBack")
        default: break
        }
    }
    override public func mouseDown(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        if let touchedNode = nodes(at: mousePoint).first {
            switch touchedNode.name {
            case "txtStart"?, "txtInstructions"?, "txtAbout"?, "txtBack"?:
                run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
                touchedNode.run(SKAction.fadeOut(withDuration: 0.5)) {
                    self.goToScene(withName: touchedNode.name!)
                }
            default: break
            }
        }
    }
    func goToScene(withName: String) {
        let toGoScene: SKScene
        switch withName {
        case "txtStart":
            toGoScene = GameSceneFile(fileNamed: "scenes/GameScene.sks")!
        case "txtInstructions":
            toGoScene = InstructionsSceneFile(fileNamed: "scenes/InstructionsScene.sks")!
        case "txtAbout":
            toGoScene = AboutSceneFile(fileNamed: "scenes/AboutScene.sks")!
        case "txtBack":
            toGoScene = SplashSceneFile(fileNamed: "scenes/SplashScene.sks")!
        default:
            toGoScene = SplashSceneFile(fileNamed: "scenes/SplashScene.sks")!
        }
        toGoScene.scaleMode = .aspectFit
        view?.presentScene(toGoScene, transition: SKTransition.fade(withDuration: 2.0))
    }
}
