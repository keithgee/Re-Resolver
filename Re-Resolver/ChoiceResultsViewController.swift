//
//  ChoiceResultsViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/13/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit


// This ViewController selects and displays the answer
// from the "Decide", "Ask", and "Choose" features.
//
// Normal behavior is for the button title to be
// blank when the view loads, and for 
// button presses to select and display a new answer.
//
// If displayResultImmediately vis set to
// true, the button title displays a result as
// soon as the view loads, and button presses
// are disabled.
class ChoiceResultsViewController: UIViewController {
    
    @IBOutlet weak var choiceButton: UIButton!
    var choices: [String]!                 // list of options from which to pick
    var menuTitle: String?                 // title for navigation bar
    var displayResultImmediately = false   // used in Choice feature
    
    @IBAction func choiceButtonPressed(button: UIButton) {
        
        button.setTitle(chooseChoice(), forState: .Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        if let title = menuTitle  {
            navigationItem.title = title
        }
        
        if displayResultImmediately == true  {
    
            // if we somehow got to this screen without any
            // choices entered, don't try to select a choice
            if choices.count > 0  {
                choiceButton.setTitle(chooseChoice(), forState: .Normal)
            }
            
            choiceButton.enabled = false
        }
        
    }

    private func chooseChoice() -> String  {
        return choices[(Int)(arc4random() % (UInt32)(choices.count))]
    }

   

   
}
