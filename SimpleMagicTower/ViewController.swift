//
//  ViewController.swift
//  SimpleMagicTower
//
//  Created by Locke on 2017/1/13.
//  Copyright © 2017年 Meitu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var king: Character!
    var queen: Character!
    var knight: Character!
    var soldier: Character!
    
    var characters: [Character]!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupAllCharacters()
    }
    
    @IBAction func beginGame(_ sender: UIButton) {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (t) in
            guard self?.king.death == false && self?.queen.death == false else {
                if self?.queen.death == true { self?.characters.remove(at: 0) }
                self?.timer?.invalidate()
                return
            }
            self?.attackedEachOther(self?.king, defender: self?.queen)
        })
        
    }
    
}

extension ViewController {
    
    fileprivate func setupAllCharacters() {
        
        let king = Character.role(.king)
        let queen = Character.role(.queen)
        let knight = Character.role(.knight)
        let soldier = Character.role(.soldier)
        
        self.king = king
        self.queen = queen
        self.knight = knight
        self.soldier = soldier
        
        self.characters = [self.king, self.queen, self.knight, self.soldier]
        
        print("\n  ================================= \n |                                  | \n \(self.king.name) 血量：\(self.king.hp) 攻击：\(self.king.attack) 防御: \(self.king.defend) 武器: \(self.king.weapon.type) \n \(self.queen.name) 血量：\(self.queen.hp) 攻击：\(self.queen.attack) 防御: \(self.queen.defend) 武器: \(self.queen.weapon.type) \n \(self.knight.name) 血量：\(self.knight.hp) 攻击：\(self.knight.attack) 防御: \(self.knight.defend) 武器: \(self.knight.weapon.type) \n \(self.soldier.name) 血量：\(self.soldier.hp) 攻击：\(self.soldier.attack) 防御: \(self.soldier.defend) 武器: \(self.soldier.weapon.type) \n")
    }
    
    fileprivate func attackedEachOther(_ attacker: Character?, defender: Character?) {
        
        guard let attacker = attacker else { return }
        guard let defender = defender else { return }
        
        let hurtValue = attacker.attack - defender.defend
        defender.hp = defender.hp - hurtValue
        print("\(attacker.name) 攻击 \(defender.name)，造成\(hurtValue)点伤害 \n 剩余血量：\(attacker.name)：\(attacker.hp)，\(defender.name)：\(defender.hp)")
    }
    
}

