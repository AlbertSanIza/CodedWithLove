import SpriteKit
public class GameSceneFile: SKScene, SKPhysicsContactDelegate {
    var thePlayer: SKSpriteNode = SKSpriteNode()
    var theLifePoints: SKLabelNode = SKLabelNode()
    var theScorePoints: SKLabelNode = SKLabelNode()
    var thePause: SKNode = SKNode()
    var theGameOver: SKNode = SKNode()
    var wKey: Bool = false
    var sKey: Bool = false
    var aKey: Bool = false
    var dKey: Bool = false
    var spaceKey: Bool = false
    var isPlaying: Bool = true
    var isGameOver: Bool = false
    var isHitPlayerAsteroid: Bool = false
    struct PhysicsCategory {
        static let None: UInt32 = 0
        static let Player: UInt32 = 0b1
        static let Asteroid: UInt32 = 0b10
        static let Shield: UInt32 = 0b11
        static let Projectile: UInt32 = 0b100
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
        if contact.bodyA.categoryBitMask == PhysicsCategory.Projectile || contact.bodyB.categoryBitMask == PhysicsCategory.Projectile {
            if contact.bodyA.categoryBitMask == PhysicsCategory.Asteroid || contact.bodyB.categoryBitMask == PhysicsCategory.Asteroid {
                fBody = contact.bodyA.categoryBitMask == PhysicsCategory.Projectile ? contact.bodyA : contact.bodyB
                sBody = contact.bodyA.categoryBitMask == PhysicsCategory.Asteroid ? contact.bodyA : contact.bodyB
                if let sksProjectile = fBody.node as? SKSpriteNode, let sksAsteroid = sBody.node as? SKSpriteNode {
                    projectileHitAsteroid(projectile: sksProjectile, asteroid: sksAsteroid, points: 1)
                }
            }
        }
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player || contact.bodyB.categoryBitMask == PhysicsCategory.Player {
            if contact.bodyA.categoryBitMask == PhysicsCategory.Asteroid || contact.bodyB.categoryBitMask == PhysicsCategory.Asteroid {
                if !isHitPlayerAsteroid {
                    fBody = contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyA : contact.bodyB
                    sBody = contact.bodyA.categoryBitMask == PhysicsCategory.Asteroid ? contact.bodyA : contact.bodyB
                    if let sksPlayer = fBody.node as? SKSpriteNode, let sksAsteroid = sBody.node as? SKSpriteNode {
                        playerHitAsteroid(player: sksPlayer, asteroid: sksAsteroid, points: -1)
                    }
                }
            }
        }
    }
    override public func update(_ currentTime: TimeInterval) {
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
                addProjectile()
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
            addAsteroid(withSize: "Big", inPosition: mousePoint)
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
        if let txtLifePoints: SKLabelNode = childNode(withName: "txtLifePoints") as! SKLabelNode?, let txtScorePoints: SKLabelNode = childNode(withName: "txtScorePoints") as! SKLabelNode? {
            theLifePoints = txtLifePoints
            theScorePoints = txtScorePoints
        }
    }
    func loadSubViews() {
        if let sknPause: SKNode = childNode(withName: "sknPause"), let sknGameOver: SKNode = childNode(withName: "sknGameOver") {
            thePause = sknPause
            theGameOver = sknGameOver
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
        var asteroid: SKSpriteNode = SKSpriteNode()
        switch withSize {
        case "Big":
            let randomSize = Int(arc4random_uniform(50) + 100)
            asteroid = SKSpriteNode(texture: SKTexture(imageNamed: "sprites/art/asteroidBig.png"), size: CGSize(width: randomSize, height: randomSize))
        case "Small":
            asteroid = SKSpriteNode(texture: SKTexture(imageNamed: "sprites/art/projectile0.png"), size: CGSize(width: 50, height: 50))
        default:
            asteroid = SKSpriteNode(texture: SKTexture(imageNamed: "sprites/art/projectile0.png"), size: CGSize(width: 50, height: 50))
        }
        asteroid.name = "asteroid" + withSize
        asteroid.position = inPosition
        asteroid.physicsBody = SKPhysicsBody(circleOfRadius: 20, center: CGPoint(x: 0, y: 0))
        asteroid.physicsBody?.isDynamic = true
        asteroid.physicsBody?.categoryBitMask = PhysicsCategory.Asteroid
        asteroid.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        asteroid.physicsBody?.collisionBitMask = PhysicsCategory.Asteroid
        addChild(asteroid)
    }
    func addProjectile() {
        let projectile = SKSpriteNode(texture: SKTexture(imageNamed: "sprites/art/projectile0.png"), size: CGSize(width: 70, height: 30))
        projectile.position = thePlayer.position
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
        shield.alpha = 0.6
        shield.physicsBody = SKPhysicsBody(circleOfRadius: 135, center: CGPoint(x: 0, y: 0))
        shield.physicsBody?.pinned = true
        shield.physicsBody?.categoryBitMask = PhysicsCategory.Shield
        shield.physicsBody?.contactTestBitMask = PhysicsCategory.Asteroid
        shield.physicsBody?.collisionBitMask = PhysicsCategory.Asteroid
        shield.physicsBody?.usesPreciseCollisionDetection = true
        let shieldFadeAction = SKAction.repeat(SKAction.sequence([SKAction.fadeAlpha(to: 0.35, duration: 0.5), SKAction.fadeAlpha(to: 0.6, duration: 0.5)]), count: 4)
        let shieldFadeSequenceAction = SKAction.sequence([shieldFadeAction, SKAction.fadeOut(withDuration: 1)])
        shield.run(shieldFadeSequenceAction) {
            self.isHitPlayerAsteroid = false
            shield.run(SKAction.removeFromParent())
        }
        return shield
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
    func projectileHitAsteroid(projectile: SKSpriteNode, asteroid: SKSpriteNode, points: Int) {
        projectile.removeFromParent()
        changeScorePoints(with: 1)
    }
    func playerHitAsteroid(player: SKSpriteNode, asteroid: SKSpriteNode, points: Int) {
        isHitPlayerAsteroid = true
        player.removeAllActions()
        changeLifePoints(with: points)
        player.run(SKAction.fadeOut(withDuration: 0.5)) {
            if !self.isGameOver {
                player.addChild(self.addShield())
                player.run(SKAction.sequence([SKAction.group([SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0), SKAction.rotate(toAngle: self.degreesToRadians(degrees: 90), duration: 0)]), SKAction.fadeIn(withDuration: 1)]))
            } else {
                player.removeFromParent()
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
