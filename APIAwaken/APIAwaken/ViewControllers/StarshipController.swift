//
//  StarshipController.swift
//  APIAwaken
//
//  Created by Dipanshu Sehrawat on 06/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import UIKit

class StarshipController: UITableViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var starshipPicker: UIPickerView!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    var starships = [Starship]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateWith(_ starship: Starship) {
        nameLabel.text = starship.name
        manufacturerLabel.text = starship.manufacturer
        costLabel.text = starship.costInCredits
        lengthLabel.text = starship.length
        classLabel.text = starship.starshipClass
        crewLabel.text = starship.crew
    }

    func updateLength() {
        var smallest = starships[0]
        var largest = starships[0]
        
        for starship in starships {
            if let starshipHeight = Double(starship.length), let smallestHeight = Double(smallest.length) {
                if starshipHeight < smallestHeight {
                    smallest = starship
                }
            }
        }
        
        for starship in starships {
            if let starshipHeight = Double(starship.length), let largestHeight = Double(largest.length) {
                if starshipHeight > largestHeight {
                    largest = starship
                }
            }
        }
        
        smallestLabel.text = smallest.name
        largestLabel.text = largest.name
    }
}

extension StarshipController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return starships.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return starships[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateWith(starships[row])
    }
    
    
}
