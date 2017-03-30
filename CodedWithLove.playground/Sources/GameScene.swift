import SpriteKit
public class GameSceneFile: SKScene, SKPhysicsContactDelegate {
    var thePlayer: SKSpriteNode = SKSpriteNode()
    var theLifePoints: SKLabelNode = SKLabelNode()
    var theScorePoints: SKLabelNode = SKLabelNode()
    var theLevel: SKLabelNode = SKLabelNode()
    var thePause: SKNode = SKNode()
    var theGameOver: SKNode = SKNode()
    var theLevelMessage: SKNode = SKNode()
    var wKey: Bool = false
    var sKey: Bool = false
    var aKey: Bool = false
    var dKey: Bool = false
    var spaceKey: Bool = false
    var isPlaying: Bool = false
    var isGameOver: Bool = false
    var isHitPlayerAsteroid: Bool = false
    var isShootProjectile: Bool = false
    var gameLevel: Int = 0
    struct PhysicsCategory {
        static let None: UInt32 = 0
        static let Player: UInt32 = 0b1
        static let Asteroid: UInt32 = 0b10
        static let Shield: UInt32 = 0b11
        static let Projectile: UInt32 = 0b100
        static let PowerUp: UInt32 = 0b101
        static let All: UInt32 = UInt32.max
    }
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        loadBackground()
        loadPlayer()
        loadStatsBoard()
        loadSubViews()
    }
    override public func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        enumerateChildNodes(withName: "sksPlanets*") {
            (node, stop) in
            node.position = self.convertPoint(fromView: CGPoint(x: CGFloat(arc4random_uniform(UInt32((self.view?.frame.width)!))), y: CGFloat(arc4random_uniform(UInt32((self.view?.frame.height)!)))))
        }
        //let backgroundMusic = SKAudioNode(fileNamed: "sounds/spaceDimensions.mp3")
        //backgroundMusic.autoplayLooped = true
        //addChild(backgroundMusic)
    }
    public func didBegin(_ contact: SKPhysicsContact) {
        var fBody: SKPhysicsBody
        var sBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask == PhysicsCategory.Asteroid || contact.bodyB.categoryBitMask == PhysicsCategory.Asteroid {
            if contact.bodyA.categoryBitMask == PhysicsCategory.Projectile || contact.bodyB.categoryBitMask == PhysicsCategory.Projectile {
                fBody = contact.bodyA.categoryBitMask == PhysicsCategory.Asteroid ? contact.bodyA : contact.bodyB
                sBody = contact.bodyA.categoryBitMask == PhysicsCategory.Projectile ? contact.bodyA : contact.bodyB
                if let sksAsteroid = fBody.node as? SKSpriteNode, let sksProjectile = sBody.node as? SKSpriteNode {
                    projectileHitAsteroid(projectile: sksProjectile, asteroid: sksAsteroid, points: 1)
                }
            } else if contact.bodyA.categoryBitMask == PhysicsCategory.Player || contact.bodyB.categoryBitMask == PhysicsCategory.Player {
                fBody = contact.bodyA.categoryBitMask == PhysicsCategory.Asteroid ? contact.bodyA : contact.bodyB
                sBody = contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyA : contact.bodyB
                if let sksAsteroid = fBody.node as? SKSpriteNode, let sksPlayer = sBody.node as? SKSpriteNode {
                    playerHitAsteroid(player: sksPlayer, asteroid: sksAsteroid, points: -1)
                }
            }
        }
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player || contact.bodyB.categoryBitMask == PhysicsCategory.Player {
            if contact.bodyA.categoryBitMask == PhysicsCategory.PowerUp || contact.bodyB.categoryBitMask == PhysicsCategory.PowerUp {
                fBody = contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyA : contact.bodyB
                sBody = contact.bodyA.categoryBitMask == PhysicsCategory.PowerUp ? contact.bodyA : contact.bodyB
                if let sksPlayer = fBody.node as? SKSpriteNode, let sksPowerUp = sBody.node as? SKSpriteNode {
                    platerHitPowerUp(player: sksPlayer, powerUp: sksPowerUp)
                }
            }
        }
    }
    override public func update(_ currentTime: TimeInterval) {
        if !isPlaying {
            isPlaying = true
            gameLevel += 1
            changeLevel(with: gameLevel)
            let aMessage: SKLabelNode = (theLevelMessage.childNode(withName: "txtLevelMessage") as? SKLabelNode)!
            aMessage.text = "3"
            theLevelMessage.run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.fadeIn(withDuration: 0.75), SKAction.fadeOut(withDuration: 0.75)])) {
                aMessage.text = "2"
                self.theLevelMessage.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.75), SKAction.fadeOut(withDuration: 0.75)])) {
                    aMessage.text = "1"
                    self.theLevelMessage.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.75), SKAction.fadeOut(withDuration: 0.75)])) {
                        aMessage.text = "Start!"
                        self.theLevelMessage.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.75), SKAction.fadeOut(withDuration: 0.75)])) {
                            
                        }
                    }
                }
            }
        }
        if wKey {
            thePlayer.run(SKAction.moveBy(x: (spaceKey ? 7 : 3) * cos(thePlayer.zRotation), y: (spaceKey ? 7 : 3) * sin(thePlayer.zRotation), duration: 0.5))
        }
        if sKey {
            thePlayer.run(SKAction.moveBy(x: -1 * cos(thePlayer.zRotation), y: -1 * sin(thePlayer.zRotation), duration: 0.3))
        }
        if aKey {
            thePlayer.run(SKAction.rotate(byAngle: degreesToRadians(degrees: 3), duration: 0.3))
        }
        if dKey {
            thePlayer.run(SKAction.rotate(byAngle: degreesToRadians(degrees: -3), duration: 0.3))
        }
        if thePlayer.physicsBody?.categoryBitMask != PhysicsCategory.None {
            if thePlayer.position.y > 400 {
                thePlayer.position.y = -398
            } else if thePlayer.position.y < -400 {
                thePlayer.position.y = 398
            }
            if thePlayer.position.x > 528 {
                thePlayer.position.x = -526
            } else if thePlayer.position.x < -528 {
                thePlayer.position.x = 526
            }
        }
        enumerateChildNodes(withName: "asteroid*") {
            (node, stop) in
            let nodeAngle = atan2((node.physicsBody?.velocity.dy)!, (node.physicsBody?.velocity.dx)!)
            node.physicsBody?.velocity = CGVector(dx: (node.name == "asteroidBig" ? 50 : 100) * cos(nodeAngle), dy: (node.name == "asteroidBig" ? 50 : 100)  * sin(nodeAngle))
            if node.position.y > 390 {
                node.position.y = -390
            } else if node.position.y < -390 {
                node.position.y = 390
            }
            if node.position.x > 518 {
                node.position.x = -518
            } else if node.position.x < -518 {
                node.position.x = 518
            }
        }
    }
    override public func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 13:
            if !wKey {
                wKey = true
                thePlayer.childNode(withName: "sksJet")?.run(SKAction.fadeAlpha(to: 0.7, duration: 0.4), withKey: "sksJet")
            }
        case 1:
            if !sKey {
                sKey = true
            }
        case 0:
            if !aKey {
                aKey = true
                if !sKey {
                    thePlayer.childNode(withName: "sksJetRight")?.run(SKAction.fadeAlpha(to: 0.7, duration: 0.4), withKey: "sksJetRight")
                }
            }
        case 2:
            if !dKey {
                dKey = true
                if !sKey {
                    thePlayer.childNode(withName: "sksJetLeft")?.run(SKAction.fadeAlpha(to: 0.7, duration: 0.4), withKey: "sksJetLeft")
                }
            }
        case 49:
            if !spaceKey {
                spaceKey = true
                if wKey {
                    thePlayer.childNode(withName: "sksJet")?.run(SKAction.fadeIn(withDuration: 0.1), withKey: "sksJet")
                }
            }
        case 31:
            if !event.isARepeat && !isPaused && !isGameOver {
                addProjectile(inPosition: thePlayer.position)
                if isShootProjectile {
                    addProjectile(inPosition: CGPoint(x: thePlayer.position.x + (50 * cos(thePlayer.zRotation + degreesToRadians(degrees: 130))), y: thePlayer.position.y + (50 * sin(thePlayer.zRotation + degreesToRadians(degrees: 130)))))
                    addProjectile(inPosition: CGPoint(x: thePlayer.position.x + (50 * cos(thePlayer.zRotation + degreesToRadians(degrees: 220))), y: thePlayer.position.y + (50 * sin(thePlayer.zRotation + degreesToRadians(degrees: 220)))))
                }
            }
        default: break
        }
    }
    override public func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 13:
            wKey = false
            thePlayer.childNode(withName: "sksJet")?.run(SKAction.fadeOut(withDuration: 0.2), withKey: "sksJet")
        case 1:
            sKey = false
        case 0:
            aKey = false
            thePlayer.childNode(withName: "sksJetRight")?.run(SKAction.fadeOut(withDuration: 0.2), withKey: "sksJetRight")
        case 2:
            dKey = false
            thePlayer.childNode(withName: "sksJetLeft")?.run(SKAction.fadeOut(withDuration: 0.2), withKey: "sksJetLeft")
        case 49:
            spaceKey = false
            if wKey {
                thePlayer.childNode(withName: "sksJet")?.run(SKAction.fadeAlpha(to: 0.7, duration: 0.2), withKey: "sksJet")
            }
        case 53, 36:
            if !isGameOver {
                if isPaused {
                    isPaused = false
                    thePause.run(SKAction.fadeOut(withDuration: 0.1))
                } else {
                    thePause.run(SKAction.fadeIn(withDuration: 0.1)) {
                        self.isPaused = true
                    }
                }
            }
        case 15:
            if isPaused && !isGameOver {
                isPaused = false
                thePause.run(SKAction.fadeOut(withDuration: 0.1))
            }
        case 46:
            if isPaused && !isGameOver {
                goToScene(withName: "txtMainMenu")
            }
        default: break
        }
    }
    override public func mouseDown(with event: NSEvent) {
        if isPaused || isGameOver {
            let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
            if let touchedNode = nodes(at: mousePoint).first {
                switch touchedNode.name {
                case "txtResume"?:
                    isPaused = false
                    thePause.run(SKAction.fadeOut(withDuration: 0.1))
                case "txtPlayAgain"?:
                    goToScene(withName: "txtPlayAgain")
                case "txtMainMenu"?:
                    goToScene(withName: "txtMainMenu")
                default: break
                }
            }
        } else {
            let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
            addAsteroid(withSize: String(arc4random_uniform(2) == 0 ? "Big" : "Small" ), inPosition: mousePoint)
        }
    }
    func loadBackground() {
        if let sksBackground: SKSpriteNode = childNode(withName: "sksBackground") as! SKSpriteNode?, let sksClouds: SKSpriteNode = childNode(withName: "sksClouds") as! SKSpriteNode?, let sksStars: SKSpriteNode = childNode(withName: "sksStars") as! SKSpriteNode?, let sksPlanets1: SKSpriteNode = childNode(withName: "sksPlanets1") as! SKSpriteNode?, let sksPlanets2: SKSpriteNode = childNode(withName: "sksPlanets2") as! SKSpriteNode? {
            sksBackground.texture = SKTexture(imageNamed: "sprites/background/backgrounds" + String(arc4random_uniform(3)) + ".png")
            sksClouds.texture = SKTexture(imageNamed: "sprites/background/clouds" + String(arc4random_uniform(4)) + String(arc4random_uniform(3)) + ".png")
            sksStars.texture = SKTexture(imageNamed: "sprites/background/starsLayer" + String(arc4random_uniform(3)) + ".png")
            sksPlanets1.texture = SKTexture(imageNamed: "sprites/art/planet" + String(arc4random_uniform(6)) + ".png")
            sksPlanets2.texture = SKTexture(imageNamed: "sprites/art/planet" + String(arc4random_uniform(6)) + ".png")
        }
    }
    func loadPlayer() {
        if let sksPlayer: SKSpriteNode = childNode(withName: "sksPlayer") as! SKSpriteNode? {
            thePlayer = sksPlayer
            thePlayer.texture = SKTexture(imageNamed: "sprites/art/player.png")
            thePlayer.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 20))
            thePlayer.physicsBody?.categoryBitMask = PhysicsCategory.Player
            thePlayer.physicsBody?.contactTestBitMask = PhysicsCategory.Asteroid
            thePlayer.physicsBody?.collisionBitMask = PhysicsCategory.None
            if let sksJet: SKSpriteNode = thePlayer.childNode(withName: "sksJet") as! SKSpriteNode?, let sksJetLeft: SKSpriteNode = thePlayer.childNode(withName: "sksJetLeft") as! SKSpriteNode?, let sksJetRight: SKSpriteNode = thePlayer.childNode(withName: "sksJetRight") as! SKSpriteNode? {
                sksJet.texture = SKTexture(imageNamed: "sprites/art/jet.png")
                sksJetLeft.texture = SKTexture(imageNamed: "sprites/art/jet.png")
                sksJetRight.texture = SKTexture(imageNamed: "sprites/art/jet.png")
            }
        }
    }
    func loadStatsBoard() {
        if let txtLifePoints: SKLabelNode = childNode(withName: "txtLifePoints") as! SKLabelNode?, let txtScorePoints: SKLabelNode = childNode(withName: "txtScorePoints") as! SKLabelNode?, let txtLevel: SKLabelNode = childNode(withName: "txtLevel") as! SKLabelNode? {
            theLifePoints = txtLifePoints
            theScorePoints = txtScorePoints
            theLevel = txtLevel
        }
    }
    func loadSubViews() {
        if let sknPause: SKNode = childNode(withName: "sknPause"), let sknGameOver: SKNode = childNode(withName: "sknGameOver"), let sknLevelMessage: SKNode = childNode(withName: "sknLevelMessage") {
            thePause = sknPause
            theGameOver = sknGameOver
            theLevelMessage = sknLevelMessage
        }
    }
    func goToScene(withName: String) {
        let toGoScene: SKScene
        switch withName {
        case "txtPlayAgain":
            toGoScene = GameSceneFile(fileNamed: "scenes/GameScene.sks")!
        case "txtMainMenu":
            toGoScene = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene.sks")!
        default:
            toGoScene = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene.sks")!
        }
        toGoScene.scaleMode = .aspectFit
        view?.presentScene(toGoScene, transition: SKTransition.fade(withDuration: 2.0))
    }
    func addAsteroid(withSize: String, inPosition: CGPoint) {
        let randomSize: Int = (withSize == "Big" ? Int(arc4random_uniform(30) + 120) : Int(arc4random_uniform(20) + 90))
        let asteroidTexture = SKTexture(imageNamed: "sprites/art/asteroid" + withSize + (withSize == "Big" ? "" : String(arc4random_uniform(2)) + String(arc4random_uniform(5))) + ".png")
        let asteroid: SKSpriteNode = SKSpriteNode(texture: asteroidTexture, size: CGSize(width: randomSize, height: randomSize))
        asteroid.name = "asteroid" + withSize
        asteroid.position = inPosition
        asteroid.zRotation = degreesToRadians(degrees: CGFloat(arc4random_uniform(359)))
        asteroid.physicsBody = SKPhysicsBody(texture: asteroidTexture, size: CGSize(width: randomSize - (withSize == "Small" ? 30 : 15), height: randomSize - (withSize == "Small" ? 30 : 15)))
        asteroid.physicsBody?.mass = 0.1
        asteroid.physicsBody?.isDynamic = true
        asteroid.physicsBody?.categoryBitMask = PhysicsCategory.Asteroid
        asteroid.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        asteroid.physicsBody?.collisionBitMask = PhysicsCategory.Asteroid
        let asteroidDirection = Double(arc4random_uniform(360))
        asteroid.physicsBody?.velocity = CGVector(dx: 100 * cos(asteroidDirection), dy: 100 * sin(asteroidDirection))
        addChild(asteroid)
    }
    func addProjectile(inPosition: CGPoint) {
        let projectile = SKSpriteNode(texture: SKTexture(imageNamed: "sprites/art/projectile0.png"), size: CGSize(width: 70, height: 30))
        projectile.position = inPosition
        projectile.zRotation = thePlayer.zRotation
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: 10, center: CGPoint(x: 0, y: 0))
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Asteroid
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
        projectile.physicsBody?.usesPreciseCollisionDetection = true
        projectile.run(SKAction.sequence([SKAction.moveBy(x: 1200 * cos(projectile.zRotation), y: 1200 * sin(projectile.zRotation), duration: 1.2), SKAction.removeFromParent()]))
        addChild(projectile)
    }
    func addShield() -> SKSpriteNode {
        let shield = SKSpriteNode(texture: SKTexture(imageNamed: "sprites/art/planet6.png"), size: CGSize(width: 360, height: 360))
        shield.name = "shield"
        shield.alpha = 0.6
        shield.physicsBody = SKPhysicsBody(circleOfRadius: 135, center: CGPoint(x: 0, y: 0))
        shield.physicsBody?.pinned = true
        shield.physicsBody?.categoryBitMask = PhysicsCategory.Shield
        shield.physicsBody?.contactTestBitMask = PhysicsCategory.Asteroid
        shield.physicsBody?.collisionBitMask = PhysicsCategory.Asteroid
        shield.physicsBody?.usesPreciseCollisionDetection = true
        shield.physicsBody?.linearDamping = 0.0;
        let shieldFadeAction = SKAction.repeat(SKAction.sequence([SKAction.fadeAlpha(to: 0.35, duration: 0.5), SKAction.fadeAlpha(to: 0.6, duration: 0.5)]), count: 4)
        let shieldFadeSequenceAction = SKAction.sequence([shieldFadeAction, SKAction.fadeOut(withDuration: 1)])
        shield.run(shieldFadeSequenceAction) {
            self.isHitPlayerAsteroid = false
            shield.run(SKAction.removeFromParent())
        }
        return shield
    }
    func addPowerUp(inPosition: CGPoint) {
        let powerUp: SKSpriteNode
        switch arc4random_uniform(16) {
        case 0, 5, 10:
            powerUp = SKSpriteNode(texture: SKTexture(imageNamed: "sprites/artRedux/powerUpLife.png"), size: CGSize(width: 50, height: 50))
            powerUp.name = "powerUpLife"
        case 1, 3, 6, 8:
            powerUp = SKSpriteNode(texture: SKTexture(imageNamed: "sprites/artRedux/powerUpShield.png"), size: CGSize(width: 50, height: 50))
            powerUp.name = "powerUpShield"
        case 2, 4, 7, 9:
            powerUp = SKSpriteNode(texture: SKTexture(imageNamed: "sprites/artRedux/powerUpShoot.png"), size: CGSize(width: 50, height: 50))
            powerUp.name = "powerUpShoot"
        default:
            powerUp = SKSpriteNode(texture: SKTexture(imageNamed: "sprites/artRedux/powerUpShoot.png"), size: CGSize(width: 50, height: 50))
            powerUp.name = "powerUpShoot"
        }
        powerUp.position = inPosition
        powerUp.physicsBody = SKPhysicsBody(circleOfRadius: 30, center: CGPoint(x: 0, y: 0))
        powerUp.physicsBody?.categoryBitMask = PhysicsCategory.PowerUp
        powerUp.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        powerUp.physicsBody?.collisionBitMask = PhysicsCategory.None
        powerUp.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.5), SKAction.repeat(SKAction.sequence([SKAction.scale(by: 1.1, duration: 0.5), SKAction.scale(by: 0.9, duration: 0.5)]), count: 8), SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
        addChild(powerUp)
    }
    func changeLifePoints(with: Int) {
        let lifePoints = Int(theLifePoints.text!)! + with
        theLifePoints.text = String(lifePoints)
        if lifePoints < 1 {
            self.isGameOver = true
            self.theGameOver.run(SKAction.fadeIn(withDuration: 0.5))
        }
    }
    func changeScorePoints(with: Int) {
        theScorePoints.text = String(Int(theScorePoints.text!)! + with)
    }
    func changeLevel(with: Int) {
        theLevel.text = "Level " + String(with)
    }
    func projectileHitAsteroid(projectile: SKSpriteNode, asteroid: SKSpriteNode, points: Int) {
        projectile.removeFromParent()
        if asteroid.colorBlendFactor >= 1 {
            asteroid.physicsBody?.categoryBitMask = PhysicsCategory.None
            asteroid.physicsBody?.contactTestBitMask = PhysicsCategory.None
            asteroid.physicsBody?.collisionBitMask = PhysicsCategory.None
            let oldAsteroidName = asteroid.name
            let oldAsteroidPosition = asteroid.position
            let oldAsteroidSize = asteroid.size
            let oldAsteroidRotation = asteroid.zRotation
            asteroid.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.removeFromParent()]))
            let explotionEmitter: SKEmitterNode = SKEmitterNode(fileNamed: (oldAsteroidName == "asteroidBig" ? "emitter/explotionBig.sks" : "emitter/explotionSmall.sks"))!
            explotionEmitter.particleTexture = SKTexture(imageNamed: "emitter/spark.png")
            explotionEmitter.alpha = 0.0
            explotionEmitter.position = oldAsteroidPosition
            explotionEmitter.particleSize = oldAsteroidSize
            addChild(explotionEmitter)
            explotionEmitter.run(SKAction.fadeIn(withDuration: 0.3)) {
                if oldAsteroidName == "asteroidBig" {
                    self.addPowerUp(inPosition: oldAsteroidPosition)
                    let theAngles = [0, 72, 144, 216, 288]
                    for angle in theAngles {
                        self.addAsteroid(withSize: "Small", inPosition: CGPoint(x: oldAsteroidPosition.x + (60 * cos(oldAsteroidRotation + self.degreesToRadians(degrees: CGFloat(angle)))), y: oldAsteroidPosition.y + (60 * sin(oldAsteroidRotation + self.degreesToRadians(degrees: CGFloat(angle))))))
                    }
                }
                explotionEmitter.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
            }
            changeScorePoints(with: (asteroid.name == "asteroidBig" ? 10 : 5))
        } else {
            asteroid.run(SKAction.colorize(with: .magenta, colorBlendFactor: (asteroid.name == "asteroidBig" ? asteroid.colorBlendFactor + 0.1 : asteroid.colorBlendFactor + 0.2), duration: 0))
            changeScorePoints(with: (asteroid.name == "asteroidBig" ? 2 : 4))
        }
    }
    func playerHitAsteroid(player: SKSpriteNode, asteroid: SKSpriteNode, points: Int) {
        isHitPlayerAsteroid = true
        player.removeAllActions()
        changeLifePoints(with: points)
        thePlayer.physicsBody?.categoryBitMask = PhysicsCategory.None
        thePlayer.physicsBody?.contactTestBitMask = PhysicsCategory.None
        thePlayer.physicsBody?.collisionBitMask = PhysicsCategory.None
        player.run(SKAction.fadeOut(withDuration: 0.5)) {
            if !self.isGameOver {
                if let oldShield: SKSpriteNode = player.childNode(withName: "shield") as? SKSpriteNode {
                    oldShield.removeFromParent()
                }
                player.addChild(self.addShield())
                player.run(SKAction.sequence([
                    SKAction.group([SKAction.move(to: CGPoint(x: 0, y: -560), duration: 0), SKAction.rotate(toAngle: self.degreesToRadians(degrees: 90), duration: 0), SKAction.fadeIn(withDuration: 0)]),
                    SKAction.move(to: CGPoint(x: 0, y: 0), duration: 2)
                    ])) {
                    self.thePlayer.physicsBody?.categoryBitMask = PhysicsCategory.Player
                    self.thePlayer.physicsBody?.contactTestBitMask = PhysicsCategory.Asteroid
                    self.thePlayer.physicsBody?.collisionBitMask = PhysicsCategory.None
                }
            } else {
                player.removeFromParent()
            }
        }
    }
    func platerHitPowerUp(player: SKSpriteNode, powerUp: SKSpriteNode) {
        powerUp.removeFromParent()
        if powerUp.name == "powerUpLife" {
            changeLifePoints(with: 1)
        } else if powerUp.name == "powerUpShield" {
            if let oldShield: SKSpriteNode = player.childNode(withName: "shield") as? SKSpriteNode {
                oldShield.removeFromParent()
            }
            player.addChild(addShield())
        } else if powerUp.name == "powerUpShoot" {
            isShootProjectile = true
            run(SKAction.wait(forDuration: 10)) {
                self.isShootProjectile = false
            }
        }
    }
    func radiansToDegrees(radians: CGFloat) -> CGFloat {
        return radians * 180 / CGFloat(M_PI)
    }
    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat(M_PI) / 180
    }
}
