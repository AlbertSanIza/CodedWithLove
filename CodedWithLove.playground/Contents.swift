import SpriteKit
import PlaygroundSupport

//let mainFrame = CGRect(x: 0, y: 0, width: 1024, height: 768)
let mainFrame = CGRect(x: 0, y: 0, width: 750, height: 563)
//let mainFrame = CGRect(x: 0, y: 0, width: 600, height: 450)

let mainView = SKView(frame: mainFrame)
mainView.showsFPS = false
mainView.showsNodeCount = false
mainView.showsPhysics = false

let splashScene: SKScene = SplashSceneFile(fileNamed: "scenes/SplashScene.sks")!
splashScene.scaleMode = .aspectFit
mainView.presentScene(splashScene)

PlaygroundPage.current.liveView = mainView
