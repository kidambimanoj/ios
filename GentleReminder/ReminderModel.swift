//
//  ReminderModel.swift
//  GentleReminder
//
//  Created by Kidambi, Manoj on 9/24/16.
//  Copyright © 2016 Kidambi, Manoj. All rights reserved.
//

import Foundation

class NumberKeypad {
    
    private var result = "0"
    
    func generateDisplay(newDisplay: String) {
        
        if result.characters.count == 10 {
            return
        }

        if result == "0" {
            if newDisplay != "0" {
                result = newDisplay
            }
            return
        }
        
        result += newDisplay
    }
    
    var display: String {
        get {
            return result
        }
    }
    
}
