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
    
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var bloodTypeLabel: UILabel!
    @IBOutlet var dateOfBirth: UILabel!
    
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
                self.queryingHealthCharacteristicType(healthStore!)
                
            }
            else
            {
                println(error.description)
            }
        })
    }
    
    
    func queryingHealthCharacteristicType(healthStore: HKHealthStore){
        
        //querying date Of Birth
        var dateOfBirth: NSDate?
        dateOfBirth = healthStore.dateOfBirthWithError(nil)
        
        if dateOfBirth != nil
        {
            var stringVersionOfDateOfBirth: String?
            stringVersionOfDateOfBirth = NSDateFormatter.localizedStringFromDate(dateOfBirth!, dateStyle:.MediumStyle, timeStyle: .NoStyle)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.dateOfBirth.text = stringVersionOfDateOfBirth!
            })
        }
    }
        
    

    
}

