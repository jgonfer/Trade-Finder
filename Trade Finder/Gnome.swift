//
//  Gnome.swift
//  Trade Finder
//
//  Created by Josep Gonzalez Fernandez on 15/2/16.
//  Copyright © 2016 Josep Gonzalez Fernandez. All rights reserved.
//

import Foundation

class Gnome {
    var id = 0
    var name = ""
    var thumbnail = ""
    var age = 0
    var weight = 0.0
    var height = 0.0
    var hair_color = ""
    var professions: [String]?
    var hasProfessions: Bool {
        guard let _ = professions else {
            return false
        }
        return true
    }
    var friends: [String]?
    var hasFriends: Bool {
        guard let _ = friends else {
            return false
        }
        return true
    }
    
    init(id: Int, name: String, thumbnail: String, age: Int, weight: Double, height: Double, hair_color: String, professions: [String]?, friends: [String]?) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.age = age
        self.weight = weight
        self.height = height
        self.hair_color = hair_color
        self.professions = professions
        self.friends = friends
    }
}