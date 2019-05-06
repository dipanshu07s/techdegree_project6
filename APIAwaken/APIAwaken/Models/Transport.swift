//
//  Transport.swift
//  APIAwaken
//
//  Created by Dipanshu Sehrawat on 06/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

class Transport: Codable {
    let name: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let crew: String
}

class Vehicle: Transport {
    let vehicleClass: String
    
    enum CodingKeys: String, CodingKey {
        case vehicleClass
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.vehicleClass = try container.decode(String.self, forKey: .vehicleClass)
        try super.init(from: decoder)
    }
}

class Starship: Transport {
    let starshipClass: String
    
    enum CodingKeys: String, CodingKey {
        case starshipClass
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.starshipClass = try container.decode(String.self, forKey: .starshipClass)
        try super.init(from: decoder)
    }
}
