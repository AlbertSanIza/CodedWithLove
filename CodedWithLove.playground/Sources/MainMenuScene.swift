import SpriteKit
import GameplayKit
public class MainMenuScene: SKScene {
    override public init(size: CGSize) {
        super.init(size: size)
        let txtTitle = SKLabelNode()
        txtTitle.text = "Main Menu"
        txtTitle.position = CGPoint(x: frame.midX, y: frame.height - 60)
        txtTitle.fontSize = 40
        let nodeMenu = SKNode()
        nodeMenu.position = CGPoint(x: frame.midX, y: frame.midY - 30)
        nodeMenu.alpha = 0.0
        let txtStart = SKLabelNode()
        txtStart.text = "START"
        txtStart.position = CGPoint(x: 0, y: 0)
        txtStart.fontSize = 80
        let txtInstructions = SKLabelNode()
        txtInstructions.text = "Instructions"
        txtInstructions.position = CGPoint(x: 0, y: -40)
        txtInstructions.fontSize = 30
        let txtAboutMe = SKLabelNode()
        txtAboutMe.text = "About Me"
        txtAboutMe.position = CGPoint(x: 0, y: -80)
        txtAboutMe.fontSize = 30
        let txtBack = SKLabelNode()
        txtBack.text = "Back"
        txtBack.position = CGPoint(x: 0, y: -120)
        txtBack.fontSize = 30
        nodeMenu.addChild(txtStart)
        nodeMenu.addChild(txtInstructions)
        nodeMenu.addChild(txtAboutMe)
        nodeMenu.addChild(txtBack)
        addChild(txtTitle)
        addChild(nodeMenu)
        let sequence = SKAction.repeatForever(SKAction.sequence(
            [SKAction.fadeOut(withDuration: 0.5),
             SKAction.fadeIn(withDuration: 2)]
        ))
        nodeMenu.run(SKAction.group(
            [SKAction.moveTo(y: frame.midY, duration: 1.0),
             SKAction.sequence([SKAction.fadeIn(withDuration: 1.5)])]
        )) {
            txtStart.run(sequence)
        }
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
            case 53:
            let mainMenuScene = SplashScene(size: (scene?.size)!)
            let fadeTransition = SKTransition.fade(withDuration: 2.0)
            self.view?.presentScene(mainMenuScene, transition: fadeTransition)
            default:break
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
