//
//  AppDelegate.swift
//  0002_SoundTest
//
//  Created by Kikutada on 2020/08/11.
//  Copyright © 2020 Kikutada All rights reserved.
//

import SpriteKit

/// CgCustomBackground creates animation textures by overriden extendTextures function.
class CgCustomBackground : CgBackgroundManager {
    override func extendTextures() -> Int {
        // Texture number assigns to 16*8.
        extendAnimationTexture(sequence: [79, 0], timePerFrame: 0.2)
        return 1  // Number of added textures by calling extendAnimationTexture function.
    }
}


class GameScene: SKScene {
    
    private var sprite: CgSpriteManager!
    private var background: CgCustomBackground!
    private var sound: CgSoundManager!
    
    override func didMove(to view: SKView) {

        // =========================================
        // Initialize Sprite and Background Manager
        // =========================================

        // Create sprite and background objects.
        sprite = CgSpriteManager(view: self, imageNamed: "spriteTest.png", width: 16, height: 16, maxNumber: 64)
        background = CgCustomBackground(view: self, imageNamed: "backgroundTest.png", width: 8, height: 8, maxNumber: 2)
        
        // Draw cherries.
        sprite.draw(0, x: 8, y: 8, texture: 3)
        sprite.draw(1, x: 16*13+8, y: 8, texture: 3)
        sprite.draw(2, x: 8, y: 16*17+8, texture: 3)
        sprite.draw(3, x: 16*13+8, y: 16*17+8, texture: 3)

        // Draw and animate a Pacman.
        sprite.setPosition(4, x: 13*8+8, y: 16*12)
        sprite.setRotation(4, radians: CGFloat(90.0 * .pi / 180.0))
        sprite.startAnimation(4, sequence: [0,1,2], timePerFrame: 0.1, repeat: true)
        
        // Draw grids on #0 background.
        background.draw(0, x: 14*8, y: 18*8, columnsInWidth: 28, rowsInHeight: 36)
        background.setDepth(0, zPosition: 0)

        for y in 0 ..< 18  {
            for x in 0 ..< 14  {
                background.put(0, column: x*2, row: y*2, columnsInwidth: 2, rowsInHeight: 2, textures: [4,5,6,7])
            }
        }

        // Print text on #1 background.
        background.draw(1, x: 14*8, y: 18*8, columnsInWidth: 28, rowsInHeight: 36)
        background.setDepth(1, zPosition: 1)

        let asciiOffset = -16*2
        background.putString(1, column: 8, row: 18, string: "SPRITEKIT TEST", offset: asciiOffset)
 
        // Put a #63 texture on #1 background.
        background.put(1, column: 14, row: 19, texture: 128)
        
        // ===============================
        // Initialize Sound Manager
        // ===============================

        sound = CgSoundManager(view: self)
        sound.reset()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        sound.play(.EatDot)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    private var x: CGFloat = 0
    private var dx: CGFloat = 0
    
    private let bgm: [CgSoundManager.EnKindOfSound] = [.BgmNormal, .BgmSpurt1, .BgmSpurt2, .BgmPower, .BgmReturn]
    private var bgmIndex: Int = 0
    private var bgmTime: Int = 0

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        // Move and animate a Ghost.
        if x == 0 {
            dx = 1
            sprite.startAnimation(5, sequence: [4,5], timePerFrame: 0.1, repeat: true)
        } else if x == 28*8 {
            dx = -1
            sprite.startAnimation(5, sequence: [6,7], timePerFrame: 0.1, repeat: true)
        }
        
        x += dx
        sprite.setPosition(5, x: x, y: 16*6)
        
        // Play back BGM.
        if bgmTime == 0 {
            bgmTime = 16*60*5  // 5s
            sound.playBGM(bgm[bgmIndex])
            bgmIndex += 1
            if bgmIndex >= bgm.count {
                bgmIndex = 0
            }
        } else {
            bgmTime -= 16
        }

        // Update sound manager.
        sound.update(interval: 16 /* ms */)
    }
}
