import SpriteKit
public class GameSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        if let sceneBackground: SKSpriteNode = childNode(withName: "sksBackground") as! SKSpriteNode? {
            var randomNumber = arc4random_uniform(3) + 1
            sceneBackground.texture = SKTexture(imageNamed: "sprites/background/backgrounds" + String(randomNumber) + ".png")
            if let sceneClouds: SKSpriteNode = childNode(withName: "sksClouds") as! SKSpriteNode? {
                randomNumber = arc4random_uniform(4) + 1
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
                randomNumber = arc4random_uniform(3) + 1
                sceneClouds.texture = SKTexture(imageNamed: "sprites/background/" + cloudsColor + "Clouds" + String(randomNumber) + ".png")
                if let sceneStars: SKSpriteNode = childNode(withName: "sksStars") as! SKSpriteNode? {
                    randomNumber = arc4random_uniform(3) + 1
                    sceneStars.texture = SKTexture(imageNamed: "sprites/background/starsLayer" + String(randomNumber) + ".png")
                    if let scenePlanets: SKSpriteNode = childNode(withName: "sksPlanets") as! SKSpriteNode? {
                        randomNumber = arc4random_uniform(7) + 1
                        let planetStyle: String
                        switch randomNumber {
                        case 1:
                            planetStyle = "Exo1"
                        case 2:
                            planetStyle = "Exo2"
                        case 3:
                            planetStyle = "Exo3"
                        case 4:
                            planetStyle = "GasGiant"
                        case 5:
                            planetStyle = "IceGiant"
                        case 6:
                            planetStyle = "RedGiant"
                        case 7:
                            planetStyle = "Sun"
                        default:
                            planetStyle = ""
                        }
                        scenePlanets.texture = SKTexture(imageNamed: "sprites/art/planet" + planetStyle + ".png")
                    }
                }
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
