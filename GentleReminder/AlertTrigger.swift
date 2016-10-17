//
//  AlertTrigger.swift
//  GentleReminder
//
//  Created by Kidambi, Manoj on 9/25/16.
//  Copyright © 2016 Kidambi, Manoj. All rights reserved.
//

import Foundation

class AlertTrigger {
    
    func isErrorAlert(_ textField: String?) -> Bool {
        return (textField?.isEmpty)!
    }
    
    func isErrorAlert(_ textField: String?,display: String?) -> Bool {
        
        return (textField?.isEmpty)!
            || display?.characters.count != 10
    }
    
}
