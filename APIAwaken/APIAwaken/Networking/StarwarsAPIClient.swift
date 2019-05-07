//
//  StarwarsAPIClient.swift
//  APIAwaken
//
//  Created by Dipanshu Sehrawat on 06/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

class StarwarsAPIClient {
    
    let session: URLSession
    let decoder = JSONDecoder()
    
    init(session: URLSessionConfiguration) {
        self.session = URLSession(configuration: session)
    }
    
    convenience init() {
        self.init(session: .default)
    }
    
    func getCharacterData(for request: URLRequest, completion: @escaping ([Character]?, Int?, APIError?) -> Void) {
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let task = session.dataTask(with: request) { (data, response, error) in
            var results = [Character]()
            DispatchQueue.main.async {
                if let data = data {
                    guard let response = response as? HTTPURLResponse else {
                        completion(nil, nil, .invalidRequest)
                        return
                    }
                    
                    if response.statusCode == 200 {
                        do {
                            let characters = try self.decoder.decode(Result<Character>.self, from: data)
                            results += characters.results
                            
                            if characters.nextPage != nil {
                                let urlRequest = URLRequest(url: URL(string: characters.nextPage!)!)
                                self.getCharacterData(for: urlRequest, completion: completion)
                            }
                            completion(results, characters.count, nil)
                        } catch {
                            completion(nil, nil, .jsonConversionError)
                        }
                    } else {
                        completion(nil, nil, .invalidRequest)
                    }
                } else {
                    completion(nil, nil, .invalidData)
                }
            }
        }
        
        task.resume()
    }
    
    func getVehicleData(for request: URLRequest, completion: @escaping ([Vehicle]?, Int?, APIError?) -> Void) {
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let task = session.dataTask(with: request) { (data, response, error) in
            var results = [Vehicle]()
            DispatchQueue.main.async {
                if let data = data {
                    guard let response = response as? HTTPURLResponse else {
                        completion(nil, nil, .invalidRequest)
                        return
                    }
                    
                    if response.statusCode == 200 {
                        do {
                            let vehicles = try self.decoder.decode(Result<Vehicle>.self, from: data)
                            results += vehicles.results
                            
                            if vehicles.nextPage != nil {
                                let urlRequest = URLRequest(url: URL(string: vehicles.nextPage!)!)
                                self.getVehicleData(for: urlRequest, completion: completion)
                            }
                            completion(results, vehicles.count, nil)
                        } catch {
                            completion(nil, nil, .jsonConversionError)
                        }
                    } else {
                        completion(nil, nil, .invalidRequest)
                    }
                } else {
                    completion(nil, nil, .invalidData)
                }
            }
        }
        
        task.resume()
    }
    
    func getStarshipData(for request: URLRequest, completion: @escaping ([Starship]?, Int?, APIError?) -> Void) {
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let task = session.dataTask(with: request) { (data, response, error) in
            var results = [Starship]()
            DispatchQueue.main.async {
                if let data = data {
                    guard let response = response as? HTTPURLResponse else {
                        completion(nil, nil, .invalidRequest)
                        return
                    }
                    
                    if response.statusCode == 200 {
                        do {
                            let starships = try self.decoder.decode(Result<Starship>.self, from: data)
                            results += starships.results
                            
                            if starships.nextPage != nil {
                                let urlRequest = URLRequest(url: URL(string: starships.nextPage!)!)
                                self.getStarshipData(for: urlRequest, completion: completion)
                            }
                            completion(results, starships.count, nil)
                        } catch {
                            completion(nil, nil, .jsonConversionError)
                        }
                    } else {
                        completion(nil, nil, .invalidRequest)
                    }
                } else {
                    completion(nil, nil, .invalidData)
                }
            }
        }
        
        task.resume()
    }
    
    func getHomeworld(with request: URLRequest, completion: @escaping (Planet?, APIError?) -> Void) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    guard let response = response as? HTTPURLResponse else {
                        completion(nil, .invalidRequest)
                        return
                    }
                    
                    if response.statusCode == 200 {
                        do {
                            let planet = try self.decoder.decode(Planet.self, from: data)
                            completion(planet, nil)
                        } catch {
                            completion(nil, .jsonConversionError)
                        }
                    } else {
                        completion(nil, .invalidRequest)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            }
        }
        
        task.resume()
    }
    
    func getVehicle(with request: URLRequest, completion: @escaping (Vehicle?, APIError?) -> Void) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    guard let response = response as? HTTPURLResponse else {
                        completion(nil, .invalidRequest)
                        return
                    }
                    
                    if response.statusCode == 200 {
                        do {
                            let vehicle = try self.decoder.decode(Vehicle.self, from: data)
                            completion(vehicle, nil)
                        } catch {
                            completion(nil, .jsonConversionError)
                        }
                    } else {
                        completion(nil, .invalidRequest)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            }
        }
        
        task.resume()
    }
    
    func getStarship(with request: URLRequest, completion: @escaping (Starship?, APIError?) -> Void) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    guard let response = response as? HTTPURLResponse else {
                        completion(nil, .invalidRequest)
                        return
                    }
                    
                    if response.statusCode == 200 {
                        do {
                            let starship = try self.decoder.decode(Starship.self, from: data)
                            completion(starship, nil)
                        } catch {
                            completion(nil, .jsonConversionError)
                        }
                    } else {
                        completion(nil, .invalidRequest)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            }
        }
        
        task.resume()
    }
}
