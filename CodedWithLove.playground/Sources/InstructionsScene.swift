import SpriteKit
public class InstructionsSceneFile: SKScene {
  override public func sceneDidLoad() {
    super.sceneDidLoad()
  }
  override public func keyUp(with event: NSEvent) {
    run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
    goToScene()
  }
  func goToScene() {
  }
}
public class InstructionsScene: SKScene {
    override public init(size: CGSize) {
        super.init(size: size)
        let txtTitle = SKLabelNode()
        txtTitle.text = "Instructions"
        txtTitle.position = CGPoint(x: frame.midX, y: frame.height - 60)
        txtTitle.fontSize = 40
        addChild(txtTitle)
        let txtBack = SKLabelNode()
        txtBack.name = "txtBack"
        txtBack.text = "Back"
        txtBack.position = CGPoint(x: 50, y: frame.height - 55)
        txtBack.fontSize = 20
        addChild(txtBack)
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 53, 11:
            run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
            goToScene()
        default:break
        }
    }
    override public func mouseDown(with event: NSEvent) {
        let positionInScene = CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
        if let touchedNode = nodes(at: positionInScene).first {
            switch touchedNode.name {
            case "txtBack"?:
                run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
                touchedNode.run(SKAction.fadeOut(withDuration: 0.5)) {
                    self.goToScene()
                }
            default: break
            }
        }
    }
    func goToScene() {
        self.view?.presentScene(MainMenuSceneFile(size: (scene?.size)!), transition: SKTransition.crossFade(withDuration: 1.0))
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
