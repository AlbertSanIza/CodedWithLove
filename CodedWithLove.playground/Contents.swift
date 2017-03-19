import SpriteKit
import PlaygroundSupport

let mainFrame = CGRect(x: 0, y: 0, width: 600, height: 350)
let mainView = SKView(frame: mainFrame)
mainView.showsFPS = true

let splashScene = SplashScene(size: mainFrame.size)
mainView.presentScene(splashScene)

PlaygroundPage.current.liveView = mainView