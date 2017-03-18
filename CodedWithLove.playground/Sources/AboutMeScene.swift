import SpriteKit

public class AboutMe: SKScene {
    override public init(size: CGSize) {
        super.init(size: size)
        let txtTitle = SKLabelNode()
        txtTitle.text = "About Me  "
        txtTitle.position = CGPoint(x: frame.midX, y: frame.height - 40)
        txtTitle.fontSize = 40
        addChild(txtTitle)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func keyUp(with event: NSEvent) {
        print(event)
    }
}
