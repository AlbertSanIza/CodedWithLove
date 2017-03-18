import SpriteKit
public class MainMenuScene: SKScene {
    override public init(size: CGSize) {
        super.init(size: size)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/*
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
 
 class MainMenuScene: SKScene {
 
 var selectedNode: SKNode?
 var shakeAction: SKAction?
 
 override init(size: CGSize) {
 super.init(size: size)
 let text = SKLabelNode(text: "Hello, World! \u{1F601}")
 text.fontColor = .white
 text.position = CGPoint(x: size.width / 2, y: size.height/2)
 addChild(text)
 makeShakeAction()
 }
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
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
 
 override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
 let touch = touches.first
 guard let positionInScene = touch?.location(in: self) else {return}
 if let touchedNode = self.nodes(at: positionInScene).first {
 selectedNode = touchedNode
 selectedNode?.run(shakeAction!, withKey: "shake")
 }
 
 }
 
 override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
 guard let touch = touches.first else {return}
 let translationInScene = touch.location(in: self) - touch.previousLocation(in: self)
 if let selected = selectedNode {
 selected.position += translationInScene
 }
 }
 
 override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
 if selectedNode != nil {
 selectedNode?.removeAction(forKey: "shake")
 selectedNode = nil
 }
 }
 }
 */
