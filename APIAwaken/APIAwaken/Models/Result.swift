//
//  Result.swift
//  APIAwaken
//
//  Created by Dipanshu Sehrawat on 06/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

class Result<Type: Codable>: Codable {
    let count: Int
    var nextPage: String?
    var results: [Type]
    
    enum CodingKeys: String, CodingKey {
        case count
        case nextPage = "next"
        case results
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.nextPage = try container.decodeIfPresent(String.self, forKey: .nextPage)
        self.results = try container.decode([Type].self, forKey: .results)
    }
}
