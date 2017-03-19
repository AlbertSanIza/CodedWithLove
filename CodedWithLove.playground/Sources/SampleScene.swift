import SpriteKit

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += ( left: inout CGPoint, right: CGPoint) {
    left = left + right
}

let degree = CGFloat(M_PI_2) / 90

public class SampleScene: SKScene {
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var selectedNode: SKNode?
    var shakeAction: SKAction?
    override public init(size: CGSize) {
        super.init(size: size)
        let text = SKLabelNode(text: "Hello, World! \u{1F601}")
        text.fontColor = .white
        text.position = CGPoint(x: size.width / 2, y: size.height/2)
        addChild(text)
        makeShakeAction()
    }
    func makeShakeAction() {
        var sequence = [SKAction]()
        for _ in 0..<10 {
            let shake = CGFloat(drand48() * 2) + 1
            let shake2 = CGFloat(drand48() * 2) + 1
            let duration = 0.08 // + (drand48() * 0.14)
            let antiClockwise = SKAction.group([
                SKAction.rotate(byAngle: degree * shake, duration: duration),
                SKAction.moveBy(x: shake, y: shake2, duration: duration)
                ])
            let clockWise = SKAction.group([
                SKAction.rotate(byAngle: degree * shake * -2, duration: duration * 2),
                SKAction.moveBy(x: shake * -2, y: shake2 * -2, duration: duration * 2)
                ])
            sequence += [antiClockwise, clockWise, antiClockwise]
        }
        shakeAction = SKAction.repeatForever(SKAction.sequence(sequence))
    }
    override public func keyUp(with event: NSEvent) {
    }
}
