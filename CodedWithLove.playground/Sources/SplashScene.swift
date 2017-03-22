import SpriteKit
public class SplashSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.playSoundFileNamed("sounds/splash.wav" , waitForCompletion: false)]))
    }
    override public func keyUp(with event: NSEvent) {
        run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
        goToScene()
    }
    func goToScene() {
        view?.presentScene(MainMenuSceneFile(fileNamed: "scenes/MainMenuScene.sks")!, transition: SKTransition.fade(withDuration: 1.0))
    }
}
