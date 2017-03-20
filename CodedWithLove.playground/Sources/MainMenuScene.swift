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
        nodeMenu.name = "nodeMenu"
        nodeMenu.position = CGPoint(x: frame.midX, y: frame.midY - 30)
        nodeMenu.alpha = 0.0
        let txtStart = SKLabelNode()
        txtStart.name = "txtStart"
        txtStart.text = "START"
        txtStart.position = CGPoint(x: 0, y: 0)
        txtStart.fontSize = 80
        let txtInstructions = SKLabelNode()
        txtInstructions.name = "txtInstructions"
        txtInstructions.text = "Instructions"
        txtInstructions.position = CGPoint(x: 0, y: -40)
        txtInstructions.fontSize = 30
        let txtAboutMe = SKLabelNode()
        txtAboutMe.name = "txtAboutMe"
        txtAboutMe.text = "About Me"
        txtAboutMe.position = CGPoint(x: 0, y: -80)
        txtAboutMe.fontSize = 30
        let txtBack = SKLabelNode()
        txtBack.name = "txtBack"
        txtBack.text = "Back"
        txtBack.position = CGPoint(x: 0, y: -120)
        txtBack.fontSize = 20
        nodeMenu.addChild(txtStart)
        nodeMenu.addChild(txtInstructions)
        nodeMenu.addChild(txtAboutMe)
        nodeMenu.addChild(txtBack)
        addChild(txtTitle)
        addChild(nodeMenu)
        let sequence = SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.fadeIn(withDuration: 2)]))
        nodeMenu.run(SKAction.group([SKAction.moveTo(y: frame.midY, duration: 1.0), SKAction.sequence([SKAction.fadeIn(withDuration: 1.5)])])) {
            txtStart.run(sequence)
        }
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
            case 53:
            goToScene(withName: "SplashScene")
            default:break
        }
    }
    override public func mouseDown(with event: NSEvent) {
        let positionInScene = CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
        if let touchedNode = self.nodes(at: positionInScene).first {
            switch touchedNode.name {
            case "txtInstructions"?:
                touchedNode.run(SKAction.fadeOut(withDuration: 0.5)) {
                    self.goToScene(withName: "InstructionsScene")
                }
            case "txtAboutMe"?:
                goToScene(withName: "AboutMeScene")
            case "txtBack"?:
                goToScene(withName: "SplashScene")
            default: break
            }
        }
    }
    func goToScene(withName: String) {
        let toGoScene: SKScene
        switch withName {
            case "InstructionsScene":
            toGoScene = SplashScene(size: (scene?.size)!)
            case "AboutMeScene":
            toGoScene = AboutMeScene(size: (scene?.size)!)
            case "SplashScene":
            toGoScene = SplashScene(size: (scene?.size)!)
            default:
            toGoScene = SplashScene(size: (scene?.size)!)
        }
        self.view?.presentScene(toGoScene, transition: SKTransition.fade(withDuration: 1.5))
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
