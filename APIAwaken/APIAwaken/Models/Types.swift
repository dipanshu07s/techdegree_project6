//
//  Types.swift
//  APIAwaken
//
//  Created by Dipanshu Sehrawat on 06/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

enum EndpointType {
    case characters
    case vehicles
    case starships
}

extension EndpointType {
    var baseUrl: URL? {
        return URL(string: "https://swapi.co/api/")
    }
    
    var request: URLRequest {
        switch self {
        case .characters: return URLRequest(url: URL(string: "people", relativeTo: baseUrl)!)
        case .vehicles: return URLRequest(url: URL(string: "vehicles", relativeTo: baseUrl)!)
        case .starships: return URLRequest(url: URL(string: "starships", relativeTo: baseUrl)!)
        }
    }
}
