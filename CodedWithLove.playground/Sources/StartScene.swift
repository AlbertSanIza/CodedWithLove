import SpriteKit
public class StartSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
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
            case "txtEasy"?, "txtHard"?, "txtBack"?:
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
        case "txtEasy":
            toGoScene = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene")!
        case "txtEasy":
            toGoScene = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene")!
        case "txtBack":
            toGoScene = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene")!
        default:
            toGoScene = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene")!
        }
        toGoScene.scaleMode = .aspectFit
        view?.presentScene(toGoScene, transition: SKTransition.crossFade(withDuration: 2.0))
    }
}
