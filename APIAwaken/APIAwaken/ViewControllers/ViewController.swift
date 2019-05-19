//
//  ViewController.swift
//  APIAwaken
//
//  Created by Dipanshu Sehrawat on 06/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let client = StarwarsAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterSegue" {
            let destination = segue.destination as! CharacterController
            
            client.getCharacterData(for: EndpointType.characters.request) { (character, count, error) in
                if let character = character {
                    destination.characters += character
                    destination.characterPicker.reloadAllComponents()
                    if destination.characters.count == count {
                        destination.updateLength()
                    }
                    
                } else if let error = error {
                    switch error {
                    case .invalidData, .invalidRequest: self.showAlertWith(title: "Network Error", message: "There is problem connecting to internet")
                    case .invalidStatusCode:
                        self.showAlertWith(title: "Invalid status code", message: "There is problem connecting to internet")
                    case .jsonConversionError:
                        self.showAlertWith(title: "Invalid data received", message: "Data received is not correct")
                    }
                }
            }
        } else if segue.identifier == "vehicleSegue" {
            let destination = segue.destination as! VehicleController
            
            client.getVehicleData(for: EndpointType.vehicles.request) { (vehicle, count, error) in
                if let vehicle = vehicle {
                    destination.vehicles += vehicle
                    destination.vehiclePicker.reloadAllComponents()
                    if destination.vehicles.count == count {
                        destination.updateLength()
                    }
                    
                } else if let error = error {
                    switch error {
                    case .invalidData, .invalidRequest: self.showAlertWith(title: "Network Error", message: "There is problem connecting to internet")
                    case .invalidStatusCode:
                        self.showAlertWith(title: "Invalid status code", message: "There is problem connecting to internet")
                    case .jsonConversionError:
                        self.showAlertWith(title: "Invalid data received", message: "Data received is not correct")
                    }
                }
            }
        } else if segue.identifier == "starshipSegue" {
            let destination = segue.destination as! StarshipController
            
            client.getStarshipData(for: EndpointType.starships.request) { (starship, count, error) in
                if let starship = starship {
                    destination.starships += starship
                    destination.starshipPicker.reloadAllComponents()
                    if destination.starships.count == count {
                        destination.updateLength()
                    }
                    
                } else if let error = error {
                    switch error {
                    case .invalidData, .invalidRequest: self.showAlertWith(title: "Network Error", message: "There is problem connecting to internet")
                    case .invalidStatusCode:
                        self.showAlertWith(title: "Invalid status code", message: "There is problem connecting to internet")
                    case .jsonConversionError:
                        self.showAlertWith(title: "Invalid data received", message: "Data received is not correct")
                    }
                }
            }
        }
    }
    
    func showAlertWith(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }


}

