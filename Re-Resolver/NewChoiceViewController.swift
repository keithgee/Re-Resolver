//
//  NewChoiceViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/13/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit


// This is the controller for the New Choice screen,
// which allows the user to enter a new choice from the keybaord


protocol NewChoiceDelegate  {
    func choiceAdded(choice: String)
}

class NewChoiceViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    var delegate: NewChoiceDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.becomeFirstResponder()
       
    }
    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.text?.characters.count == 0  {
            return false
        }
        
        textField.resignFirstResponder()
        delegate?.choiceAdded(textField.text!)
        navigationController?.popViewControllerAnimated(true)
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        print("Finished editing")
    }
   
}
