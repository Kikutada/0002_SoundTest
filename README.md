# Sound Manager

"Sound Manager" makes it easy to play back sounds. 
It uses the framework of Spritekit. "SoundManager.swift" file provides below features.

For example, if you want to play back a specified sound:

```swift
play(.EatDot)
```

Also, if you want to play BGM which repeats the specified sound file foever:

```swift
playBGM(.BgmPower)
```


# Sample

When you run the program, the following screen will be displayed and BGM played.

When you touch screen, "16_pacman_eatdot_256ms.wav" sound is played back.

<img src="https://github.com/Kikutada/0002_SoundTest/blob/master/images/0002_soundTest.png?raw=true" width=288>

# Usages

To play back sound, create CgSpriteManager class and call the APIs.

```swift
// Create a sound manager object.
let sound = CgSoundManager(view: self)

// Reset settings
sound.reset()
        
// Play sound
sound.play(.EatDot)

```

To implement BGM, "update" method must be called regularly. For example, if you implement it in ”GameScene: SKScene"：

```swift
class GameScene: SKScene {

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        // Update sound manager.
        sound.update(interval: 16 /* ms */)
    }

}
```

# APIs

* reset()
* play(_ number: EnKindOfSound)
* stop(_ number: EnKindOfSound)
* playBGM(_ number: EnKindOfSound)
* stopBGM()
* enableOutput(_ enabled: Bool)


# Sound files


PACMAN sound files are available as samples.
WAV format of all files is 16bit, mono and 22050Hz.

* 16_pacman_eatdot_256ms.wav    11,372bytes
* 16_pacman_eatfruit_438ms.wav	 19,360bytes
* 16_pacman_eatghost_544ms.wav	 24,040bytes
* 16_pacman_miss_1536ms.wav	 67,788bytes
* 16_pacman_extrapac_1952ms.wav	 86,166bytes
* 16_credit_224ms.wav	  9,634bytes
* 16_BGM_normal_400ms.wav	 17,852bytes
* 16_BGM_power_400ms.wav	 17,750bytes
* 16_BGM_return_528ms.wav	23,366bytes
* 16_BGM_spurt1_352ms.wav	 15,592bytes
* 16_BGM_spurt2_320ms.wav	 14,212bytes
* 16_BGM_spurt3_592ms.wav	 26,272bytes
* 16_BGM_spurt4_512ms.wav	 23,018bytes
* 16_pacman_beginning_4224ms.wav	187,054bytes
* 16_pacman_intermission_5200ms.wav	229,388bytes


# Enviornments

* Swift 5.0
* Xcode 11.6
* iOS 12.2

# Author

* Kikutada

# License

"Sound Manager" is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).

