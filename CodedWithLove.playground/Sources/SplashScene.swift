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
        let txtTitle = SKLabelNode()
        txtTitle.text = "CODED WITH LOVE"
        txtTitle.position = CGPoint(x: 0, y: 0)
        txtTitle.fontSize = 46
        let txtSubTitle = SKLabelNode()
        txtSubTitle.text = "by: Albert Sanchez"
        txtSubTitle.position = CGPoint(x: 0, y: -25)
        txtSubTitle.fontSize = 26
        nodeTitle.addChild(txtLove)
        nodeTitle.addChild(txtTitle)
        nodeTitle.addChild(txtSubTitle)
        let txtStart = SKLabelNode()
        txtStart.text = "Press any key to continue..."
        txtStart.position = CGPoint(x: frame.midX, y: 20)
        txtStart.fontSize = 20
        txtStart.alpha = 0.0
        addChild(nodeTitle)
        addChild(txtStart)
        let sequence = SKAction.repeatForever(SKAction.sequence([SKAction.fadeIn(withDuration: 0.50), SKAction.wait(forDuration: 1.5), SKAction.fadeOut(withDuration: 0.50)]))
        nodeTitle.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.playSoundFileNamed("sounds/splash.wav" , waitForCompletion: false), SKAction.fadeIn(withDuration: 2.0)])) {
            txtStart.run(sequence)
        }
    }
    override public func keyUp(with event: NSEvent) {
        run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
        goToScene()
    }
    func goToScene() {
        self.view?.presentScene(MainMenuScene(size: (scene?.size)!), transition: SKTransition.fade(withDuration: 1.0))
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
