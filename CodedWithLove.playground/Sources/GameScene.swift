import SpriteKit
public class GameSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        if let sceneBackground: SKSpriteNode = childNode(withName: "sksBackground") as! SKSpriteNode? {
            var randomNumber = arc4random_uniform(4 - 1) + 1
            sceneBackground.texture = SKTexture(imageNamed: "sprites/spaceBackground/backgrounds" + String(randomNumber) + ".png")
            if let sceneClouds: SKSpriteNode = childNode(withName: "sksClouds") as! SKSpriteNode? {
                randomNumber = arc4random_uniform(4 - 1) + 1
                let cloudsColor: String
                switch randomNumber {
                case 1:
                    cloudsColor = "green"
                case 2:
                    cloudsColor = "orange"
                case 3:
                    cloudsColor = "purple"
                case 4:
                    cloudsColor = "red"
                default:
                    cloudsColor = "red"
                }
                randomNumber = arc4random_uniform(3 - 1) + 1
                sceneClouds.texture = SKTexture(imageNamed: "sprites/spaceBackground/" + cloudsColor + "Clouds" + String(randomNumber) + ".png")
                if let sceneStars: SKSpriteNode = childNode(withName: "sksStars") as! SKSpriteNode? {
                    randomNumber = arc4random_uniform(3 - 1) + 1
                    sceneStars.texture = SKTexture(imageNamed: "sprites/spaceBackground/starsLayer" + String(randomNumber) + ".png")
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
