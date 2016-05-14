//
//  ResolverAskViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/13/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit

class ResolverAskViewController: UIViewController {

    
    @IBAction func askButtonPressed(button: UIButton) {
        
        button.setTitle(chooseAnswer(), forState: .Normal)
    }
    
    // Most of these answers were all stolen from Magic 8 ball
    // https://en.wikipedia.org/wiki/Magic_8-Ball
    //
    // Just a few were taken from Amanda's demonstration video
    // of Resolver
    //
    // TODO: Replace all with genuine Resolver answers
    private func chooseAnswer() -> String  {
        
        let answers = ["It is certain",
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
        
        return answers[(Int)(arc4random() % (UInt32)(answers.count))]
    }

    
    

}
