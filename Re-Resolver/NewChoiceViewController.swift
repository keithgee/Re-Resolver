//
//  NewChoiceViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/13/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit


// This is the controller for the New Choice screen,
// which allows the user to enter a new choice from the keyboard


protocol NewChoiceDelegate: class  {
    func choiceAdded(choice: String)
}

class NewChoiceViewController: UIViewController, UITextFieldDelegate,
RecentItemDelegate {

    @IBOutlet private weak var textField: UITextField!
    weak var delegate: NewChoiceDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
        // prevent multiple items in navigation bar
        // from being pressed simultaneously, which
        // can corrupt the navigation stack
     
        if let navigationBarViews = navigationController?.navigationBar.subviews  {
            for view in navigationBarViews  {
                view.exclusiveTouch = true
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
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
   
    // MARK: RecentItemDelegate
    // Set the text in the field to whatever
    // recent item was selected from the table
    func recentItemSelected(item: String)  {
        textField.text = item
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RecentSegue"  {
            let recentController = segue.destinationViewController as! RecentTableViewController
            recentController.delegate = self
            textField.resignFirstResponder()
        }
    }
}
