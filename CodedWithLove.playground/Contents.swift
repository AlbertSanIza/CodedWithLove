import SpriteKit
import PlaygroundSupport

let mainFrame = CGRect(x: 0, y: 0, width: 500, height: 300)
let mainView = SKView(frame: mainFrame)
mainView.showsFPS = true

let splashScene = MainMenuScene(size: mainFrame.size)
mainView.presentScene(splashScene)

PlaygroundPage.current.liveView = mainView
