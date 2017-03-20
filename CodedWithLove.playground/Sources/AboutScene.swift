import SpriteKit
public class AboutScene: SKScene {
    override public init(size: CGSize) {
        super.init(size: size)
        let txtTitle = SKLabelNode()
        txtTitle.name = "txtTitle"
        txtTitle.text = "About"
        txtTitle.position = CGPoint(x: frame.midX, y: frame.height - 60)
        txtTitle.fontSize = 40
        addChild(txtTitle)
        let txtBack = SKLabelNode()
        txtBack.name = "txtBack"
        txtBack.text = "Back"
        txtBack.position = CGPoint(x: 50, y: frame.height - 55)
        txtBack.fontSize = 20
        addChild(txtBack)
        let nodeText = SKNode()
        nodeText.name = "nodeText"
        nodeText.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(nodeText)
        let txtMessage01 = SKLabelNode()
        txtMessage01.name = "txtMessage01"
        txtMessage01.text = " WWDC 2017 Scholarship Entry"
        txtMessage01.position = CGPoint(x: 0, y: 50)
        txtMessage01.fontSize = 18
        nodeText.addChild(txtMessage01)
        let txtMessage02 = SKLabelNode()
        txtMessage02.name = "txtMessage02"
        txtMessage02.text = "CODED WITH LOVE"
        txtMessage02.position = CGPoint(x: 0, y: 0)
        txtMessage02.fontSize = 50
        nodeText.addChild(txtMessage02)
        let txtMessage03 = SKLabelNode()
        txtMessage03.name = "txtMessage03"
        txtMessage03.text = "by: Albert Sanchez"
        txtMessage03.position = CGPoint(x: 0, y: -20)
        txtMessage03.fontSize = 18
        nodeText.addChild(txtMessage03)
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
        self.view?.presentScene(MainMenuScene(size: (scene?.size)!), transition: SKTransition.fade(withDuration: 1.5))
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
