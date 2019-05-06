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
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    var vehicles = [Vehicle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateWith(_ vehicle: Vehicle) {
        nameLabel.text = vehicle.name
        manufacturerLabel.text = vehicle.manufacturer
        costLabel.text = vehicle.costInCredits
        lengthLabel.text = vehicle.length
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
