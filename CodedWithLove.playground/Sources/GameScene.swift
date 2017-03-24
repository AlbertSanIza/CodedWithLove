import SpriteKit
public class GameSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        if let sceneBackground: SKSpriteNode = childNode(withName: "sksBackground") as! SKSpriteNode? {
            sceneBackground.texture = SKTexture(imageNamed: "sprites/spaceBackground/backgrounds2.png")
            if let sceneClouds: SKSpriteNode = childNode(withName: "sksClouds") as! SKSpriteNode? {
                sceneClouds.texture = SKTexture(imageNamed: "sprites/spaceBackground/orangeClouds2.png")
                if let sceneStars: SKSpriteNode = childNode(withName: "sksStars") as! SKSpriteNode? {
                    sceneStars.texture = SKTexture(imageNamed: "sprites/spaceBackground/starsLayer2.png")
                }
            }
        }
    }
    override public func keyUp(with event: NSEvent) {
        run(SKAction.playSoundFileNamed("sounds/pick.wav" , waitForCompletion: false))
        goToScene(withName: "")
    }
    func goToScene(withName: String) {
        let toGoScene: SKScene
        switch withName {
        default:
            toGoScene = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene.sks")!
        }
        toGoScene.scaleMode = .aspectFit
        view?.presentScene(toGoScene, transition: SKTransition.crossFade(withDuration: 2.0))
    }
}
