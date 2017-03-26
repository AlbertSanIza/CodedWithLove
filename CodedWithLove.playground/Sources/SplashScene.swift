import SpriteKit
public class SplashSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        if let sceneStars: SKSpriteNode = childNode(withName: "sksStars") as! SKSpriteNode? {
            sceneStars.texture = SKTexture(imageNamed: "sprites/background/starsLayer2.png")
        }
        run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.playSoundFileNamed("sounds/splash.wav" , waitForCompletion: false)]))
    }
    override public func keyUp(with event: NSEvent) {
        run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
        goToScene()
    }
    func goToScene() {
        let mainMenuScene: SKScene = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene.sks")!
        mainMenuScene.scaleMode = .aspectFit
        view?.presentScene(mainMenuScene, transition: SKTransition.fade(withDuration: 2.0))
    }
}
