//
//  ChoiceResultsViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/13/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit


// This displays the result from the "Choose" screens.
class ChoiceResultsViewController: UIViewController {

    
    @IBOutlet weak var choiceButton: UIButton!
    var choices: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // if we somehow got to this screen without any
        // choices entered, don't do anything
        if (choices.count > 0)  {
        choiceButton.setTitle(chooseChoice(), forState: .Normal)
        }
       
    }

    
    private func chooseChoice() -> String  {
   
        return choices[(Int)(arc4random() % (UInt32)(choices.count))]
    }

   

   
}
