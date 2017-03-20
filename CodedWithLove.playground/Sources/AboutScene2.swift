import SpriteKit
public class AboutScene2: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 53, 11:
            run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
            goToScene()
        default:break
        }
    }
    override public func mouseDown(with event: NSEvent) {
        let positionInScene = CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
        if let touchedNode = self.nodes(at: positionInScene).first {
            print(touchedNode)
            switch touchedNode.name {
            case "txtBack"?:
                run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
                touchedNode.run(SKAction.fadeOut(withDuration: 0.25)) {
                    self.goToScene()
                }
            default: break
            }
        } else {
            print("nada")
        }
    }
    func goToScene() {
        view?.presentScene(MainMenuScene(size: (scene?.size)!), transition: SKTransition.crossFade(withDuration: 1.0))
    }
}
