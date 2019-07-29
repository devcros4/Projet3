//
//  Character.swift
//  Projet3
//
//  Created by DELCROS Jean-baptiste on 10/06/2019.
//  Copyright © 2019 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation

class Character {
    // name of character
    var name: String
    // left life point of character
    var pvLeft: Int
    // total life point of character
    var pvTotal: Int
    // weapon of character
    var weapon: Weapon
    // heal of character
    var heal: Heal?
    
    
    init(name: String, pvTotal: Int, weapon: Weapon, heal: Heal? = nil) {
        self.name = name
        self.pvTotal = pvTotal
        self.pvLeft = pvTotal
        self.weapon = weapon
        self.heal = heal
    }
    // indicates if the characterss is dead
    var isDead:Bool {
        if self.pvLeft <= 0 {
            self.pvLeft = 0
            return true
        }
        return false
    }
    // attacking a character and if the pvLeft is less than 0 the reset to 0
    func attack(character: Character) {
        character.pvLeft -= self.weapon.attackDamage
        if character.pvLeft < 0 {
            character.pvLeft = 0
        }
    }
    // heal a character and if the pvLeft is more than pvTotal reset to pvTotal
    func heal(character: Character) {
        if let heal = self.heal {
            character.pvLeft += heal.regainPv
        }
        if character.pvLeft > character.pvTotal {
            character.pvLeft = character.pvTotal
        }
    }
    
    // allows to change the weapon of the character
    func switchWeapon(weapon: Weapon) {
        self.weapon = weapon
    }
    
    // return information from the Chest
    func toString() -> String {
        if self.heal != nil {
            return "name: \(self.name)     ❤️: \(self.pvLeft) / \(self.pvTotal)   \(self.weapon.toString())       \(self.heal!.toString())"
        } else {
            return "name: \(self.name)     ❤️: \(self.pvLeft) / \(self.pvTotal)   \(self.weapon.toString())"
        }
        
    }
}
