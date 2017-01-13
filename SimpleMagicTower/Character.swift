//
//  Character.swift
//  SimpleMagicTower
//
//  Created by Locke on 2017/1/13.
//  Copyright © 2017年 Meitu. All rights reserved.
//

import UIKit

struct Weapon {
    
    enum Name: UInt32 {
        case sword      = 0
        case dagger     = 1
        case bow        = 2
        case axe        = 3
    }
    
    var attack = 0
    
    var type: Name = .sword {
        didSet {
            switch type {
            case .sword:
                self.attack = 15
            case .dagger:
                self.attack = 5
            case .bow:
                self.attack = 10
            case .axe:
                self.attack = 20
            }
        }
    }
    
    static func new() -> Weapon {
        
        let random = arc4random() % 4
        let type = Name(rawValue: random)
        var weapon = Weapon()
        weapon.type = type!
        return weapon
    }
}

class Character: NSObject {
    
    enum Role {
        case king
        case queen
        case knight
        case soldier
        case unknown
    }
    
    var name = ""       // 名字
    var attack = 0      // 攻击
    var defend = 0      // 防御
    var death = false   // 是否死亡
    
    var hp = 0 {    // 血量
        
        didSet {
            if hp <= 0 { self.death = true }
        }
    }
    
    var weapon = Weapon.new() {
        
        didSet {
            self.attack += weapon.attack
        }
    }
    
    var role: Role = .unknown {
        
        didSet {
            switch role {
            case .king:
                self.role("国王", hp: 500, attack: 50, defend: 5)
            case .queen:
                self.role("皇后", hp: 400, attack: 40, defend: 4)
            case .knight:
                self.role("骑士", hp: 200, attack: 20, defend: 3)
            case .soldier:
                self.role("士兵", hp: 100, attack: 10, defend: 2)
            case .unknown:
                self.role("未知", hp: 0, attack: 0, defend: 0)
            }
        }
    }
    
    private func role(_ name: String, hp: Int, attack: Int, defend: Int) {
        self.name = name
        self.hp = hp
        self.attack = attack
        self.defend = defend
    }
    
    class func role(_ role: Role) -> Character {
        let character = Character()
        character.role = role
        character.weapon = Weapon.new()
        return character
    }
    
}
