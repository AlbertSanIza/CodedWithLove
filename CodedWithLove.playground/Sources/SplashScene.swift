import SpriteKit

public class SplashScene: SKScene {
    override public init(size: CGSize) {
        super.init(size: size)
        backgroundColor = .black
        let txtTitle = SKLabelNode(fontNamed: "Baskerville-Bold")
        txtTitle.text = "CODED WITH \u{2764}"
        txtTitle.position = CGPoint(x: frame.midX, y: frame.midY)
        txtTitle.fontSize = 50
        addChild(txtTitle)
        let txtSubTitle = SKLabelNode(fontNamed: "Apple Color Emoji")
        txtSubTitle.text = "By: Albert Sanchez"
        txtSubTitle.position = CGPoint(x: frame.midX - 85 , y: frame.midY - 25)
        txtSubTitle.fontSize = 20
        addChild(txtSubTitle)
        let txtStart = SKLabelNode(fontNamed: "Apple Color Emoji")
        txtStart.text = "Start"
        txtStart.position = CGPoint(x: frame.midX, y: 40)
        txtStart.fontSize = 18
        addChild(txtStart)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
