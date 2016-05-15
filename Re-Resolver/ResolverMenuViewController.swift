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

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
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
            choiceResultsController.choices = ["Yes", "No"]
            
        }  else if segue.identifier == "AskSegue"  {
            let choiceResultsController = segue.destinationViewController as! ChoiceResultsViewController
            choiceResultsController.menuTitle = "Ask"
            
            // Most of these answers were all stolen from Magic 8 ball
            // https://en.wikipedia.org/wiki/Magic_8-Ball
            //
            // Just a few were taken from Amanda's demonstration video
            // of Resolver
            //
            // TODO: Replace all with genuine Resolver answers
            choiceResultsController.choices =
                ["It is certain",
                 "It is decidedly so",
                 "Without a doubt",
                 "Yes, definitely",
                 "You may rely on it",
                 "As I see it, yes",
                 "Most likely",
                 "Outlook good",
                 "Yes",
                 "Signs point to yes",
                 "Reply hazy try again",
                 "Ask again later",
                 "Better not tell you now",
                 "Cannot predict now",
                 "Concentrate and ask again",
                 "Don't count on it",
                 "My reply is no",
                 "My sources say no",
                 "Outlook not so good",
                 "Very doubtful",
                           
                 // Below are genuine Resolver answers
                 "Oh Yeah!",
                 "According to NASA the answer is no.",
                 "Nope, Sorry!"
            ]
        }
        
        // No preparation necessary for segue to "Choose" screens
        
    }
}

