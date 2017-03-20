import SpriteKit
public class InstructionsScene: SKScene {
    override public init(size: CGSize) {
        super.init(size: size)
        let txtTitle = SKLabelNode()
        txtTitle.text = "Instructions"
        txtTitle.position = CGPoint(x: frame.midX, y: frame.height - 60)
        txtTitle.fontSize = 40
        addChild(txtTitle)
    }
    override public func keyUp(with event: NSEvent) {
        goToScene()
    }
    func goToScene() {
        self.view?.presentScene(MainMenuScene(size: (scene?.size)!), transition: SKTransition.fade(withDuration: 1.5))
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
