//
//  ResolverChooseViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/13/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit

// This controller is for the screen that lets a user press
// a button that responds "Yes" or "No"

class ResolverChooseViewController: UIViewController {

    @IBAction func chooseButtonPressed(button: UIButton) {
        
        button.setTitle(chooseAnswer(), forState: .Normal)
    }
  
    
    
    // TODO: Test to make sure this is about 50% yes/no
    private func chooseAnswer() -> String  {
        
        let answers = ["Yes", "No"]
        return answers[(Int)(arc4random() % 2)]
    }
  
}
