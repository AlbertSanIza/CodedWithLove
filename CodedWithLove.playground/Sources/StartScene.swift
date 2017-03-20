import SpriteKit
public class StartScene: SKScene {
    override public init(size: CGSize) {
        super.init(size: size)
        let txtTitle = SKLabelNode()
        txtTitle.text = "Start"
        txtTitle.position = CGPoint(x: frame.midX, y: frame.height - 60)
        txtTitle.fontSize = 40
        addChild(txtTitle)
        let txtBack = SKLabelNode()
        txtBack.name = "txtBack"
        txtBack.text = "Back"
        txtBack.position = CGPoint(x: 50, y: frame.height - 55)
        txtBack.fontSize = 20
        addChild(txtBack)
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 53:
            run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
            goToScene()
        default:break
        }
    }
    override public func mouseDown(with event: NSEvent) {
        let positionInScene = CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
        if let touchedNode = nodes(at: positionInScene).first {
            switch touchedNode.name {
            case "txtBack"?:
                run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
                touchedNode.run(SKAction.fadeOut(withDuration: 0.25)) {
                    self.goToScene()
                }
            default: break
            }
        }
    }
    func goToScene() {
        self.view?.presentScene(MainMenuScene(size: (scene?.size)!), transition: SKTransition.crossFade(withDuration: 1.0))
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
