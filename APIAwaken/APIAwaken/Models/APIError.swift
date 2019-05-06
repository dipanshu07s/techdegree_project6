//
//  APIError.swift
//  APIAwaken
//
//  Created by Dipanshu Sehrawat on 06/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case invalidRequest
    case invalidStatusCode
    case invalidData
    case jsonConversionError
}
