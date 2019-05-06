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
    
    var characters = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func updateWith(_ character: Character) {
        nameLabel.text = character.name
        birthYearLabel.text = character.birthYear
        homeLabel.text = ""
        heightLabel.text = character.height
        eyesLabel.text = character.eyeColor
        hairLabel.text = character.hairColor
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
        let character = characters[row]
        let url = URL(string: character.homeworld)!
        let request = URLRequest(url: url)
        client.getHomeworld(with: request) { (planet, error) in
            if let planet = planet {
                self.homeLabel.text = planet.name
            } else if let error = error {
                print(error.rawValue)
            }
        }
        updateWith(characters[row])
    }
}
