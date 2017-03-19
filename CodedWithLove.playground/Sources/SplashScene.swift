import SpriteKit
public class SplashScene: SKScene {
    override public init(size: CGSize) {
        super.init(size: size)
        backgroundColor = .black
        let nodeTitle = SKNode()
        nodeTitle.position = CGPoint(x: frame.midX, y: frame.midY)
        nodeTitle.alpha = 0.0
        let txtLove = SKLabelNode()
        txtLove.text = "👨🏽‍💻❤️"
        txtLove.position = CGPoint(x: 0, y: 42)
        txtLove.fontSize = 50
        let txtTitle = SKLabelNode(fontNamed: "Chalkduster")
        txtTitle.text = "CODED WITH LOVE"
        txtTitle.position = CGPoint(x: 0, y: 0)
        txtTitle.fontSize = 46
        let txtSubTitle = SKLabelNode(fontNamed: "Chalkduster")
        txtSubTitle.text = "By: Albert Sanchez"
        txtSubTitle.position = CGPoint(x: 0, y: -25)
        txtSubTitle.fontSize = 26
        nodeTitle.addChild(txtLove)
        nodeTitle.addChild(txtTitle)
        nodeTitle.addChild(txtSubTitle)
        let txtStart = SKLabelNode()
        txtStart.text = "Press spacebar to start..."
        txtStart.position = CGPoint(x: frame.midX, y: 20)
        txtStart.fontSize = 20
        txtStart.alpha = 0.0
        addChild(nodeTitle)
        addChild(txtStart)
        let fadeIn = SKAction.fadeIn(withDuration: 0.50)
        let fadeWait = SKAction.wait(forDuration: 2.0)
        let fadeOut = SKAction.fadeOut(withDuration: 0.50)
        let sequence = SKAction.repeatForever(SKAction.sequence([fadeIn, fadeWait, fadeOut]))
        txtStart.run(sequence)
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
            case 0x31:
            let mainMenuScene = MainMenuScene(size: (scene?.size)!)
            let fadeTransition = SKTransition.fade(withDuration: 2.0)
            self.view?.presentScene(mainMenuScene, transition: fadeTransition)
            default: break
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
