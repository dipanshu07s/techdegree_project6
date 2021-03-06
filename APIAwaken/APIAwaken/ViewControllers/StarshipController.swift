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
    @IBOutlet weak var costSegmentedControl: UISegmentedControl!
    @IBOutlet weak var lengthSegmentedControl: UISegmentedControl!
    
    var starships = [Starship]()
    var exchangeRate: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateWith(_ starship: Starship) {
        nameLabel.text = starship.name
        manufacturerLabel.text = starship.manufacturer
        changeCostMetric(costSegmentedControl)
        changeLengthMetric(lengthSegmentedControl)
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
    
    
    @IBAction func changeCostMetric(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            if let exchangeRate = exchangeRate {
                if let text = Double(starships[starshipPicker.selectedRow(inComponent: 0)].costInCredits) {
                    self.costLabel.text = "$\(text / exchangeRate)"
                } else {
                    self.costLabel.text = "unknown"
                }
                
            } else {
                let alert = UIAlertController(title: "Exchange Rate", message: "Please enter an exchange rate", preferredStyle: .alert)
                alert.addTextField(configurationHandler: nil)
                let action = UIAlertAction(title: "Ok", style: .default) { (action) in
                    if let text = alert.textFields![0].text, let exchangeRate = Double(text) {
                        let cost = Double(self.starships[self.starshipPicker.selectedRow(inComponent: 0)].costInCredits)!
                        self.costLabel.text = "$\(cost / exchangeRate)"
                        self.exchangeRate = exchangeRate
                    } else {
                        self.costLabel.text = "Invalid rate"
                    }
                    
                }
                alert.addAction(action)
                present(alert, animated: true)
            }
            
        } else {
            costLabel.text = starships[starshipPicker.selectedRow(inComponent: 0)].costInCredits
        }
    }
    @IBAction func changeLengthMetric(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            let heightInCm = Double(starships[starshipPicker.selectedRow(inComponent: 0)].length)!
            let heightInMeters = heightInCm / 100
            lengthLabel.text = "\(heightInMeters)m"
        } else {
            let starshipHeight = Double(starships[starshipPicker.selectedRow(inComponent: 0)].length)!
            lengthLabel.text = "\(starshipHeight)cm"
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
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
