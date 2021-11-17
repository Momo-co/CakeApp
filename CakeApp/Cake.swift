//
//  Cake.swift
//  CakeApp
//
//  Created by Suman Gurung on 14/11/2021.
//

import Foundation

struct Cake: Decodable {
    var title:String
    var desc:String
    var image:String
    
}

struct Animal: Decodable {
    var animalId:String
    var name:String
    var animalDetail:String
    var age: Int
    var dangerScale: Int
    var colour:String
    
    enum CodingKeys:String, CodingKey {
        case animalId = "animal_id"
        case name, age, colour
        case animalDetail = "animal_detail"
        case dangerScale = "danger_scale"
    }
}
