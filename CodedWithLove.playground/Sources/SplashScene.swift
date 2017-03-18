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
        txtTitle.fontSize = 40
        addChild(txtTitle)
        let txtSubTitle = SKLabelNode(fontNamed: "Chalkduster")
        txtSubTitle.text = "By: Albert Sanchez"
        txtSubTitle.position = CGPoint(x: frame.midX, y: frame.midY - 25)
        txtSubTitle.fontSize = 20
        addChild(txtSubTitle)
        let txtStart = SKLabelNode(fontNamed: "Arial")
        txtStart.text = "Press any key to Start"
        txtStart.position = CGPoint(x: frame.midX, y: 20)
        txtStart.fontSize = 16
        addChild(txtStart)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
