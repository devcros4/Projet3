//
//  CareWeapon.swift
//  Projet3
//
//  Created by DELCROS Jean-baptiste on 10/06/2019.
//  Copyright © 2019 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation

class Heal {
    
    var name: String
    
    var regainPv: Int
    
    init(name: String, regainPv: Int) {
        self.name = name
        self.regainPv = regainPv
    }
    
    // return information from the Heal
    func toString() -> String {
        return "💉: \(self.name)(dammage: \(self.regainPv))"
    }
}
