//
//  AppDelegate.swift
//  0002_SoundTest
//
//  Created by Kikutada on 2020/08/11.
//  Copyright © 2020 Kikutada. All rights reserved.
//

import Foundation
import SpriteKit

enum EnKindOfSound: Int {
    case EatDot = 0
    case EatFruit
    case EatGhost
    case Disappear
    case ExtraPacman
    case Credit
    case BgmNormal
    case BgmSpurt1
    case BgmSpurt2
    case BgmSpurt3
    case BgmSpurt4
    case BgmPower
    case BgmReturn
    case Beginning
    case Intermission
}


class CgSoundManager /*: CbContainer*/ {

    let table_urls: [[(resourceName: String, typeName: String, interval: Int)]] = [
        [ ("16_pacman_eatDot_256ms", "wav", 256) ],
        [ ("16_pacman_eatfruit_438ms", "wav", 438) ],
        [ ("16_pacman_eatghost_544ms", "wav", 544) ],
        [ ("16_pacman_miss_1536ms", "wav", 1536) ],
        [ ("16_pacman_extrapac_1952ms", "wav", 1952) ],
        [ ("16_credit_224ms", "wav", 224) ],
        [ ("16_BGM_normal_400ms", "wav", 400) ],
        [ ("16_BGM_spurt1_352ms", "wav", 352) ],
        [ ("16_BGM_spurt2_320ms", "wav", 320) ],
        [ ("16_BGM_spurt3_592ms", "wav", 592) ],
        [ ("16_BGM_spurt4_512ms", "wav", 512) ],
        [ ("16_BGM_power_400ms", "wav", 400) ],
        [ ("16_BGM_return_528ms", "wav", 528) ],
        [ ("16_pacman_beginning_4224ms", "wav", 4224) ],
        [ ("16_pacman_intermission_5200ms", "wav", 5200) ]
    ]

    private var view: SKScene?
    private var actions: [SKAction] = []
    private var table_playingTime: [Int] = []
    private var soundEnabled = true
    
    private let triggerThresholdTime: Int = 32

    private var bgmEnabled: Bool = false
    private var bgmNumber: Int = -1
    private var bgmTime: Int = 0
/*
    init(binding object: CbObject, view: SKScene) {
        super.init(binding: object)
        self.view = view
        table_playingTime = Array<Int>(repeating: 0, count: table_urls.count)

        for t in table_urls {
            appendResource(resourceName: t[0].resourceName, typeName: t[0].typeName)
        }
    }
*/
    func reset() {
        soundEnabled = true
        bgmEnabled = false
        bgmNumber = -1
        bgmTime = 0

        for i in 0 ..< table_urls.count {
            table_playingTime[i] = 0
        }
    }
/*
    override func handleEvent(sender: CbObject, message: EnMessage, parameter values: [Int]) {
        if message == .SystemClock {
            let interval = values[0]
            if bgmEnabled {
                if bgmTime > 0 {
                    bgmTime -= interval
                    if bgmTime <= 0 {
                        let table = table_urls[bgmNumber]
                        bgmTime = table[0].interval
                        view?.run(actions[bgmNumber])
                    }
                }
            }
            for i in 0 ..< table_urls.count {
                if table_playingTime[i] > 0 {
                    table_playingTime[i] -= interval
                }
            }
        }
    }
*/
    func appendResource(resourceName: String, typeName: String) {
        let fileName = resourceName+"."+typeName
        let sound: SKAction = SKAction.playSoundFileNamed(fileName, waitForCompletion: false)
        actions.append(sound)
    }

    func playBGM(_ number: EnKindOfSound) {
        guard number.rawValue < actions.count && soundEnabled else { return }
        if bgmEnabled && number.rawValue == bgmNumber { return }
        bgmNumber = number.rawValue
        if bgmTime <= triggerThresholdTime {
            bgmEnabled = true
            let table = table_urls[bgmNumber]
            bgmTime = table[0].interval
            view?.run(actions[bgmNumber])
        }
    }

    func stopBGM() {
        bgmEnabled = false
        bgmTime = 0
    }

    func play(_ number: EnKindOfSound) {
        guard number.rawValue < actions.count && soundEnabled else { return }

        let _number = number.rawValue
        if table_playingTime[_number] <= triggerThresholdTime {
            view?.run(actions[_number])
            let table = table_urls[_number]
            table_playingTime[_number] = table[0].interval
        }
    }

    func stop(_ number: EnKindOfSound) {
        guard number.rawValue < actions.count else { return }

        table_playingTime[number.rawValue] = 0
    }
    
    func enableOutput(_ enabled: Bool) {
        soundEnabled = enabled
    }

}

