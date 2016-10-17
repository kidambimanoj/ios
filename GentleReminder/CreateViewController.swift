//
//  ViewController.swift
//  GentleReminder
//
//  Created by Kidambi, Manoj on 9/21/16.
//  Copyright © 2016 Kidambi, Manoj. All rights reserved.
//

import UIKit
import MessageUI

class CreateViewController: UIViewController, UITextFieldDelegate,
    UIPickerViewDelegate, UIPickerViewDataSource,
    UITextViewDelegate,
MFMessageComposeViewControllerDelegate {
    
    
    // MARK: Models
    private var alert = AlertTrigger()
    
    var pickerData = ["None": "", "Anusha":"8324549864", "Manoj":"8327858331"]
    
    // MARK: Outlets
    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var myNamePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumber.delegate = self
        phoneNumber.keyboardType = .numberPad
        nameField.delegate = self
        textView.delegate = self
        myNamePicker.delegate = self
        myNamePicker.dataSource = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField != phoneNumber {
            return true
        }
        
        
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        
        let bool = string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
        
        if(bool) {
            if phoneNumber.text! == "0" {
                phoneNumber.text! = ""
                return false
            }
        }
        
        return bool && phoneNumber.text!.characters.count < 10
    }
    
       
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(pickerData.keys)[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameField.text = Array(pickerData.keys)[row]
        phoneNumber.text = pickerData[Array(pickerData.keys)[row]]
    }
    
    
    // MARK: Actions
    @IBAction func reset(_ sender: UIButton) {
        phoneNumber.text = pickerData.first?.value
        nameField.text = pickerData.first?.key
        textView.text = ""
    }
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        
        print("landsacpe mode called")
        
        return UIInterfaceOrientationMask.portrait
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case MessageComposeResult.cancelled :
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func send(_ sender: UIButton) {
        
        if alert.isErrorAlert(textView.text, display: phoneNumber.text){
            let title = "Error"
            let message = "Enter the ph# and the text"
            let alertController = UIAlertController(
                title: "\(title)",
                message: "\(message)",
                preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(
                title: "Dismiss",
                style: UIAlertActionStyle.default,
                handler: nil))
            
            self.present(
                alertController, animated: true, completion:nil)
            
            return
        }
        
        let title = "Hello \(nameField.text!)"
        let message = "I would like to remind you about \(textView.text!)"
        
        
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = title + message
        messageVC.recipients = [phoneNumber.text!]
        messageVC.messageComposeDelegate = self;
        
        self.present(messageVC, animated: false, completion: nil)
    }
    
}
