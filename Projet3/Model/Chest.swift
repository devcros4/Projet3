//
//  Chest.swift
//  Projet3
//
//  Created by DELCROS Jean-baptiste on 10/07/2019.
//  Copyright © 2019 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation


class Chest {
    // Weapon in the chest
    var weapon: Weapon
    
    init(weapon: Weapon) {
        self.weapon = weapon
    }
    // return information from the Chest
    func toString() -> String {
        return "the open chest contains \(self.weapon.toString())"
    }
}
