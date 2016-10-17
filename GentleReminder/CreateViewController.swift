//
//  ViewController.swift
//  GentleReminder
//
//  Created by Kidambi, Manoj on 9/21/16.
//  Copyright © 2016 Kidambi, Manoj. All rights reserved.
//

import UIKit
import MessageUI

class CreateViewController: UIViewController, UITextFieldDelegate, MFMessageComposeViewControllerDelegate {
    
    
    // MARK: Models
    private var keypad = NumberKeypad()
    private var alert = AlertTrigger()
    
    // MARK: Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Actions
    
    @IBAction func buttonClick(_ sender: UIButton) {
        keypad.generateDisplay(newDisplay: sender.currentTitle!)
        display.text = keypad.display
    }
    
    @IBAction func reset(_ sender: UIButton) {
        //reset keypad
        keypad = NumberKeypad()
        display.text = keypad.display
        
        //reset other fields
        nameField.text = ""
        textField.text = ""
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
        
        if alert.isErrorAlert(textField.text, display: display.text){
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
        let message = "I would like to remind you about \(textField.text!)"
        
        
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = title + message
        messageVC.recipients = [display.text!]
        messageVC.messageComposeDelegate = self;
        
        self.present(messageVC, animated: false, completion: nil)
        
        
     
        
           }
    
}
