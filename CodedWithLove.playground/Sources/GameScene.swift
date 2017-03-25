import SpriteKit
public class GameSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        if let sceneBackground: SKSpriteNode = childNode(withName: "sksBackground") as! SKSpriteNode? {
            sceneBackground.texture = SKTexture(imageNamed: "sprites/background/backgrounds" + String(arc4random_uniform(2)) + ".png")
            if let sceneClouds: SKSpriteNode = childNode(withName: "sksClouds") as! SKSpriteNode? {
                sceneClouds.texture = SKTexture(imageNamed: "sprites/background/clouds" + String(arc4random_uniform(3)) + String(arc4random_uniform(2)) + ".png")
                if let sceneStars: SKSpriteNode = childNode(withName: "sksStars") as! SKSpriteNode? {
                    sceneStars.texture = SKTexture(imageNamed: "sprites/background/starsLayer" + String(arc4random_uniform(2)) + ".png")
                    if let scenePlanets1: SKSpriteNode = childNode(withName: "sksPlanets1") as! SKSpriteNode? {
                        scenePlanets1.texture = SKTexture(imageNamed: "sprites/art/planet" + String(arc4random_uniform(6)) + ".png")
                        if let scenePlanets2: SKSpriteNode = childNode(withName: "sksPlanets2") as! SKSpriteNode? {
                            scenePlanets2.texture = SKTexture(imageNamed: "sprites/art/planet" + String(arc4random_uniform(6)) + ".png")
                        }
                    }
                }
            }
        }
        if let sknPlayer: SKNode = childNode(withName: "sknPlayer") {
            if let sksPlayer: SKSpriteNode = sknPlayer.childNode(withName: "sksPlayer") as! SKSpriteNode? {
                sksPlayer.texture = SKTexture(imageNamed: "sprites/art/player.png")
            }
            if let sksJet: SKSpriteNode = sknPlayer.childNode(withName: "sksJet") as! SKSpriteNode? {
                sksJet.texture = SKTexture(imageNamed: "sprites/art/jet.png")
            }
        }
    }
    override public func didMove(to view: SKView) {
        enumerateChildNodes(withName: "sksPlanets*") {
            (node, stop) in
            node.position = self.convertPoint(fromView: CGPoint(x: CGFloat(arc4random_uniform(600)), y: CGFloat(arc4random_uniform(450))))
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
