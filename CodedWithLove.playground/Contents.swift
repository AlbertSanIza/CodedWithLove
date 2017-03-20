import SpriteKit
import PlaygroundSupport

let mainFrame = CGRect(x: 0, y: 0, width: 700, height: 400)
let mainView = SKView(frame: mainFrame)
mainView.showsFPS = true
mainView.showsNodeCount = true

let splashScene = SplashScene(size: mainFrame.size)
splashScene.scaleMode = .aspectFill
mainView.presentScene(splashScene)

PlaygroundPage.current.liveView = mainView
