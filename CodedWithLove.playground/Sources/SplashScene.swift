import SpriteKit
public class SplashScene: SKScene {
    override public init(size: CGSize) {
        super.init(size: size)
        backgroundColor = .black
        let txtLove = SKLabelNode()
        txtLove.text = "👨🏽‍💻❤️"
        txtLove.position = CGPoint(x: frame.midX, y: frame.midY  + 42)
        txtLove.fontSize = 50
        addChild(txtLove)
        let txtTitle = SKLabelNode(fontNamed: "Chalkduster")
        txtTitle.text = "CODED WITH LOVE"
        txtTitle.position = CGPoint(x: frame.midX, y: frame.midY)
        txtTitle.fontSize = 46
        addChild(txtTitle)
        let txtSubTitle = SKLabelNode(fontNamed: "Chalkduster")
        txtSubTitle.text = "By: Albert Sanchez"
        txtSubTitle.position = CGPoint(x: frame.midX, y: frame.midY - 25)
        txtSubTitle.fontSize = 26
        addChild(txtSubTitle)
        let txtStart = SKLabelNode()
        txtStart.text = "Press spacebar to start..."
        txtStart.position = CGPoint(x: frame.midX, y: 20)
        txtStart.fontSize = 20
        addChild(txtStart)
    }
    override public func sceneDidLoad() {
        self.label = self.childNode(withName: "//pressLabel") as? SKLabelNode
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
            case 0x31:
            let mainMenuScene = MainMenuScene(size: (scene?.size)!)
            self.view?.presentScene(mainMenuScene)
            default: break
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
