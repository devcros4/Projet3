//
//  Game.swift
//  Projet3
//
//  Created by DELCROS Jean-baptiste on 10/06/2019.
//  Copyright © 2019 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation

class Game {
    var team1Play: Bool = Bool.random()
    var weapons: [Weapon] = []
    var characters: [Character] = []
    var heals: [Heal] = []
    var chest: Chest
    var team1: Team
    var team2: Team
    
    
    init() {
        self.team1 = Team(name: "Player 1")
        self.team2 = Team(name: "Player 2")
        self.chest = Chest(weapon: Weapon(name: "", attackDamage: 1))
        // create data for start the game
        self.initializationWeapon()
        self.initializationHeal()
        self.initializationCharacters()
    }
    
    func start() {
        var nbLap = 0
        // choice of characters
        for _ in 1...3 {
            self.choiceOneCharacter(team: self.team1)
            self.choiceOneCharacter(team: self.team2)
        }
        print("\u{001B}[2J")
       self.team1.toStringCharacters()
       self.team2.toStringCharacters()
        
        // begin game alternately
        repeat {
            nbLap += 1
            if team1Play {
                lap(teamAttack: team1, teamDefense: team2)
                self.team1Play = false
            } else {
                lap(teamAttack: team2, teamDefense: team1)
                self.team1Play = true
            }
        } while !self.gameIsFinish
        
        // end of the game winning team poster and scores
        if self.team1.charactersIsDead {
            print("\u{001B}[2J")
            print("\(self.team1.name) win the game in \(nbLap) lap")
        } else {
            print("\(self.team2.name) win the gamein \(nbLap) lap")
        }
        
        self.team1.toStringCharacters()
        self.team2.toStringCharacters()
    
    }
    
    /// MARK: Lap of the game
    func lap(teamAttack: Team, teamDefense: Team) {
        print(ANSIColors.white.rawValue + "Lap of the \(teamAttack.name)")
        let randomNumber = Int.random(in: 1 ... 10)
        if randomNumber < 3 {
            useChest(teamAttack: teamAttack)
        }
        print(ANSIColors.white.rawValue + "Select one character in your team")
        teamAttack.toStringCharacters()
        var indexCharacterAttack: Int = 0
        repeat {
            indexCharacterAttack = writeNumber()
        } while indexCharacterAttack > teamAttack.characters.count || indexCharacterAttack == 0 || teamAttack.characters[indexCharacterAttack-1].isDead
        
        if  teamAttack.characters[indexCharacterAttack-1].heal != nil {
            print("wrote 'H' for heal OR 'A' for attack")
            var healORAttack = ""
            repeat {
                healORAttack = ""
                healORAttack = readLine() ?? ""
            } while healORAttack != "H" && healORAttack != "A"
            
            if healORAttack == "H" {
               healOtherCharacter(teamAttack: teamAttack, teamDefense: teamDefense, indexCharacterAttack: indexCharacterAttack)
            } else {
                attackOtherCharacter(teamAttack: teamAttack, teamDefense: teamDefense, indexCharacterAttack: indexCharacterAttack)
            }
        } else {
            attackOtherCharacter(teamAttack: teamAttack, teamDefense: teamDefense, indexCharacterAttack: indexCharacterAttack)
        }
       
    }
    
    func useChest(teamAttack: Team) {
        let max = self.weapons.count - 1
        chest.weapon = self.weapons[Int.random(in: 0 ... max)]
        var indexCharacterSwitchWeapon = 0
        print(ANSIColors.yellow.rawValue + chest.toString())
        teamAttack.toStringCharacters()
        print("choose the character to whom you want this weapon's attributes.")
        repeat {
            indexCharacterSwitchWeapon = writeNumber()
        } while indexCharacterSwitchWeapon > teamAttack.characters.count || indexCharacterSwitchWeapon == 0
        teamAttack.characters[indexCharacterSwitchWeapon-1].switchWeapon(weapon: self.chest.weapon)
    }
    
    func healOtherCharacter(teamAttack: Team, teamDefense: Team,indexCharacterAttack: Int) {
        let characters = [teamAttack.characters[indexCharacterAttack-1]]
        teamAttack.toStringCharacters(charactersLeftOut: characters)
        var indexCharacterHeal: Int = 0
        repeat {
            indexCharacterHeal = writeNumber()
        } while indexCharacterHeal > teamAttack.characters.count || indexCharacterHeal == 0 || teamAttack.characters[indexCharacterHeal-1].isDead
        teamAttack.characters[indexCharacterAttack-1].heal(character: teamAttack.characters[indexCharacterHeal-1])
        
    }
    
    func attackOtherCharacter(teamAttack: Team, teamDefense: Team,indexCharacterAttack: Int) {
        print(ANSIColors.white.rawValue + "choose a character from the opposing team to attack")
        teamDefense.toStringCharacters()
        var indexCharacterDefense: Int = 0
        repeat {
            indexCharacterDefense = writeNumber()
        } while indexCharacterAttack > teamAttack.characters.count || indexCharacterAttack == 0 || teamDefense.characters[indexCharacterDefense-1].isDead
        teamAttack.characters[indexCharacterAttack-1].attack(character:teamDefense.characters[indexCharacterDefense-1] )
    }
    
    // lets us know if the game is over, that is, if one of the teams no longer has any characters alive
    var gameIsFinish: Bool {
        if self.team1.charactersIsDead || self.team2.charactersIsDead {
            return true
        }
        return false
    }
    
   
    
   private func writeNumber() -> Int{
        var index: Int = 0
        var getSaisie: String = ""
        var errorEntry = false
        repeat {
            if let saisie = readLine() {
                getSaisie = saisie
            }
            
            if let i = Int(getSaisie) {
                index = i
                errorEntry = false
            } else {
                errorEntry = true
                print(ANSIColors.white.rawValue + "typing error enter a number")
            }
        } while errorEntry
        return index
    }
    
    // MARK: Choice of 3 characters in by team
    
    /// view all available characters
    private func afficherCharacters(characters: [Character]){
        var index: Int = 1
        var afficheCharacter = ""
        for character in characters {
            afficheCharacter = ANSIColors.white.rawValue + "\(index) -   \(character.toString())"
            print(afficheCharacter)
            index += 1
        }
    }
    /// allows to choose a character for his team among the basic characters
    func choiceOneCharacter(team: Team) {
        self.afficherCharacters(characters: self.characters)
        print(ANSIColors.white.rawValue + "\(team.name): type the number of the character you have chosen: ")
        var index: Int = 0
        repeat {
            index = writeNumber()
        } while index > self.characters.count || index == 0
        team.characters.append(self.characters[index-1])
        self.characters.remove(at: index-1)
    }
    
    
    // MARK: Initialization of the differente data for start the game
    private func initializationWeapon() {
        self.weapons.append(Weapon(name: "arc", attackDamage: 60))
        self.weapons.append(Weapon(name: "sniper", attackDamage: 120))
        self.weapons.append(Weapon(name: "gun", attackDamage: 40))
        self.weapons.append(Weapon(name: "shotgun", attackDamage: 80))
    }
    
    private func initializationHeal() {
        self.heals.append(Heal(name: "little heal", regainPv: 50))
    }
    
    private func initializationCharacters() {
        self.characters.append(Nurse(name: "hugo", pvTotal: 210, weapon: weapons[0], heal: heals[0]))
        self.characters.append(Soldier(name: "paul", pvTotal: 220, weapon: weapons[1]))
        self.characters.append(Soldier(name: "louis", pvTotal: 230, weapon: weapons[2]))
        self.characters.append(Soldier(name: "victor", pvTotal: 240, weapon: weapons[3]))
        self.characters.append(Soldier(name: "maxime", pvTotal: 250, weapon: weapons[0]))
        self.characters.append(Soldier(name: "thomas", pvTotal: 260, weapon: weapons[1]))
        self.characters.append(Soldier(name: "sacha", pvTotal: 270, weapon: weapons[2]))
        self.characters.append(Soldier(name: "enzo", pvTotal: 280, weapon: weapons[3]))
    }
}

// enumeration of color codes for the terminal
enum ANSIColors: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
}
