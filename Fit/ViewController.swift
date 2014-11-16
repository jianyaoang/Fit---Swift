//
//  ViewController.swift
//  Fit
//
//  Created by Jian Yao Ang on 11/16/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

import UIKit
import HealthKit
import Foundation

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accessHealthStore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func accessHealthStore(){
        
        let healthStore: HKHealthStore? = {
            if HKHealthStore.isHealthDataAvailable(){
                return HKHealthStore()
            }
            else
            {
                println("Can't retrieve info")
                return nil
            }
        }()
        
        let dateOfBirthCharacteristic = HKCharacteristicType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)
        
        let bloodType = HKCharacteristicType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBloodType)
        
        let gender = HKCharacteristicType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBiologicalSex)
        
        let readDataTypes = NSSet(objects: gender, bloodType, dateOfBirthCharacteristic)
        
        healthStore?.requestAuthorizationToShareTypes(nil, readTypes: readDataTypes, completion: { (success, error) -> Void in
            
            if success
            {
                println("Request Authorization Successful")
            }
            else
            {
                println(error.description)
            }
        })
    }
    

    

    
}

