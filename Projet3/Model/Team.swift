//
//  Team.swift
//  Projet3
//
//  Created by DELCROS Jean-baptiste on 10/06/2019.
//  Copyright © 2019 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation


class Team {
    // name of team 
    var name: String
    
    // list of 3 characters
    var characters: [Character] = []
    
    init(name: String) {
       self.name = name
    }
    // indicates if all characters are dead
    var charactersIsDead: Bool {
        for character in self.characters {
            if !character.isDead {
                return false
            }
        }
        return true
    }
    // print all characters of the team of except the characters in parameter
    func toStringCharacters(charactersLeftOut: [Character]? = nil){
        print(ANSIColors.white.rawValue + "\(self.name) Characters: ")
        
        var index: Int = 1
       
        for character in self.characters {
            if let charactersLeftOut = charactersLeftOut {
                if charactersLeftOut.firstIndex(where: { (char) -> Bool in
                    return char.name != character.name
                }) != nil {
                        printCharacter(character: character, index: index)
                    }
            } else {
                printCharacter(character: character, index: index)
            }
                
            index += 1
        }
    }
    // to display the characters alive in green and the characters die in red
    private func printCharacter(character: Character, index: Int) {
         var afficheCharacter = ""
        afficheCharacter = "\(index) -   \(character.toString())"
        if character.isDead {
            print(ANSIColors.red.rawValue + afficheCharacter)
        } else {
            print(ANSIColors.green.rawValue + afficheCharacter)
        }
    }
}
