//
//  ResolverMenuViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/13/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//


import UIKit

// This is the controller for the main menu screen of Re-Resolver.
// 
// This controller is responsible for hiding
// the top navigation bar when the view appears, and allowing it
// to display again when the view disappears.
//
// The iOS status bar style is set to "light" for visibility on
// the dark background.

class ResolverMenuViewController: UIViewController {

    
    let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate

    
    @IBOutlet weak var decideButton: UIButton!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var askButton: UIButton!
    
    
    // The choices for the ChooseViewController are, oddly,
    // in this class so that they can be persisted when the
    // "Choices" screen is dismissed and removed from memory.
    // 
    // Under the current application architecture, 
    // This ResolverMenuViewController will stay in memory
    // for the life of the application.
    //
    // TODO: Think of a better way to persist these choices
    // in memory besides storing them in this controller.
    // Maybe a separate data model class?
    var choices = ChoiceList(choices: [String]() )
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set buttons so that only one at a time
        // will respond to touches
        
        decideButton.exclusiveTouch = true
        chooseButton.exclusiveTouch = true
        askButton.exclusiveTouch = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // kind of ugly here. still not sure how to make
        // color code nice
    
        if let gradientView = view as? ResolverGradientView  {
            gradientView.colorComponents = appDelegate?.backgroundGradient
            gradientView.setNeedsDisplay()
        }
    }
   
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "DecideSegue"  {
            let choiceResultsController = segue.destinationViewController as! ChoiceResultsViewController
            choiceResultsController.menuTitle = "Decide"
            choiceResultsController.choiceList = ResolverConstants.decideChoices
            
        }  else if segue.identifier == "AskSegue"  {
            let choiceResultsController = segue.destinationViewController as! ChoiceResultsViewController
            choiceResultsController.menuTitle = "Ask"
            choiceResultsController.choiceList = ResolverConstants.askChoices
        }
        else if segue.identifier == "ChooseSegue"  {
            
            // inject any saved choices into the table on the "Choose" screen
            let chooseController = segue.destinationViewController as! ChooseViewController
            chooseController.choiceList = choices
        }
        
        
    }
}

