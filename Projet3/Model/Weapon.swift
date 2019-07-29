//
//  Weapon.swift
//  Projet3
//
//  Created by DELCROS Jean-baptiste on 10/06/2019.
//  Copyright © 2019 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation

class Weapon {
    
    var name: String
    
    var attackDamage: Int
    
    init(name: String, attackDamage: Int) {
        self.name = name
        self.attackDamage = attackDamage
    }
    
    // return information from the Weapon
    func toString() -> String {
        return "⚔️: \(self.name)(dammage: \(self.attackDamage))"
    }
}
