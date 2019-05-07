//
//  VehicleController.swift
//  APIAwaken
//
//  Created by Dipanshu Sehrawat on 06/05/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import UIKit

class VehicleController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var vehiclePicker: UIPickerView!
    @IBOutlet weak var lengthSegmentedControl: UISegmentedControl!
    @IBOutlet weak var costSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    var vehicles = [Vehicle]()
    var exchangeRate: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateWith(_ vehicle: Vehicle) {
        nameLabel.text = vehicle.name
        manufacturerLabel.text = vehicle.manufacturer
        changeCostMetric(costSegmentedControl)
        changeLengthMetric(lengthSegmentedControl)
        classLabel.text = vehicle.vehicleClass
        crewLabel.text = vehicle.crew
    }
    
    func updateLength() {
        var smallest = vehicles[0]
        var largest = vehicles[0]
        
        for vehicle in vehicles {
            
            if let vehicleHeight = Double(vehicle.length), let smallestHeight = Double(smallest.length) {
                if vehicleHeight < smallestHeight {
                    smallest = vehicle
                }
            }
        }
        
        for vehicle in vehicles {
            if let vehicleHeight = Double(vehicle.length), let largestHeight = Double(smallest.length) {
                if vehicleHeight > largestHeight {
                    largest = vehicle
                }
            }
        }
        
        smallestLabel.text = smallest.name
        largestLabel.text = largest.name
    }
    
    @IBAction func changeLengthMetric(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            let heightInCm = Double(vehicles[vehiclePicker.selectedRow(inComponent: 0)].length)!
            let heightInMeters = heightInCm / 100
            lengthLabel.text = "\(heightInMeters)m"
        } else {
            let vehicleHeight = Double(vehicles[vehiclePicker.selectedRow(inComponent: 0)].length)!
            lengthLabel.text = "\(vehicleHeight)cm"
        }
    }
    
    @IBAction func changeCostMetric(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            if let exchangeRate = exchangeRate {
                if let text = Double(vehicles[vehiclePicker.selectedRow(inComponent: 0)].costInCredits) {
                    self.costLabel.text = "$\(exchangeRate / text)"
                }
                
            } else {
                let alert = UIAlertController(title: "Exchange Rate", message: "Please enter an exchange rate", preferredStyle: .alert)
                alert.addTextField(configurationHandler: nil)
                let action = UIAlertAction(title: "Ok", style: .default) { (action) in
                    self.exchangeRate = Double(alert.textFields![0].text!)!
                    let cost = Double(self.vehicles[self.vehiclePicker.selectedRow(inComponent: 0)].costInCredits)!
                    self.costLabel.text = "$\(cost / self.exchangeRate!)"
                }
                alert.addAction(action)
                present(alert, animated: true)
            }
            
        } else {
            costLabel.text = vehicles[vehiclePicker.selectedRow(inComponent: 0)].costInCredits
        }
    }
}

extension VehicleController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vehicles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return vehicles[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        updateWith(vehicles[row])
    }
    
    
}
