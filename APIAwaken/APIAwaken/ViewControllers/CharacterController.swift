//
//  CharacterController.swift
//  APIAwaken
//
//  Created by Dipanshu Sehrawat on 06/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import UIKit

class CharacterController: UITableViewController {
    
    let client = StarwarsAPIClient()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var eyesLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    @IBOutlet weak var characterPicker: UIPickerView!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var vehiclesLabel: UILabel!
    @IBOutlet weak var starshipsLabel: UILabel!
    
    var characters = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func updateWith(_ character: Character) {
        nameLabel.text = character.name
        birthYearLabel.text = character.birthYear
        homeLabel.text = ""
        changeHeight(segmentedControl)
        eyesLabel.text = character.eyeColor
        hairLabel.text = character.hairColor
        vehiclesLabel.text = ""
        starshipsLabel.text = ""
    }
    
    func updateLength() {
        var smallest = characters[0]
        var largest = characters[0]
        
        for character in characters {
            if let characterHeight = Double(character.height), let smallestHeight = Double(smallest.height) {
                if characterHeight < smallestHeight {
                    smallest = character
                }
            }
        }
        
        for character in characters {
            if let characterHeight = Double(character.height), let largestHeight = Double(largest.height) {
                if characterHeight > largestHeight {
                    largest = character
                }
            }
        }
        
        smallestLabel.text = smallest.name
        largestLabel.text = largest.name
    }
    
    @IBAction func changeHeight(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
            let heightInCm = Double(characters[characterPicker.selectedRow(inComponent: 0)].height)!
            let heightInMeters = heightInCm / 100
            heightLabel.text = "\(heightInMeters)m"
        } else {
            let characterHeight = Double(characters[characterPicker.selectedRow(inComponent: 0)].height)!
            heightLabel.text = "\(characterHeight)cm"
        }
    }
    
    func getHomeworld() {
        let character = characters[characterPicker.selectedRow(inComponent: 0)]
        let url = URL(string: character.homeworld)!
        let request = URLRequest(url: url)
        client.getHomeworld(with: request) { (planet, error) in
            if let planet = planet {
                self.homeLabel.text = planet.name
            } else if let error = error {
                print(error.rawValue)
            }
        }
    }
    
    func getVehicles() {
        let character = characters[characterPicker.selectedRow(inComponent: 0)]
        for vehicle in character.vehicles {
            let url = URL(string: vehicle)!
            let urlRequest = URLRequest(url: url)
            client.getVehicle(with: urlRequest) { (vehicle, error) in
                if let vehicle = vehicle {
                    if let text = self.vehiclesLabel.text, text.count > 1 {
                        self.vehiclesLabel.text = "\(text), \(vehicle.name)"
                    } else {
                        self.vehiclesLabel.text = "\(vehicle.name)"
                    }
                    
                }
            }
        }
    }
    
    func getStarships() {
        let character = characters[characterPicker.selectedRow(inComponent: 0)]
        for starship in character.starships {
            let url = URL(string: starship)!
            let urlRequest = URLRequest(url: url)
            client.getStarship(with: urlRequest) { (starship, error) in
                if let starship = starship {
                    if let text = self.starshipsLabel.text, text.count > 1 {
                        self.starshipsLabel.text = "\(text), \(starship.name)"
                    } else {
                        self.starshipsLabel.text = "\(starship.name)"
                    }
                } else if let error = error {
                    print(error.rawValue)
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}

extension CharacterController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return characters[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        segmentedControl.isHidden = false
        getHomeworld()
        getVehicles()
        getStarships()
        updateWith(characters[row])
    }
    
    
}
