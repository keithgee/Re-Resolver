//
//  ResolverConstants.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/15/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import Foundation

// This file contains data used in the application,
// such as:
//
//   -list of responses to the "Decide" and "Ask" features.
//   - filenames used to load and save data
//
struct ResolverConstants  {
    
    // MARK: lists of choices
    // For the "Decide" feature
    static let decideChoices = ChoiceList(choices: ["Yes", "No"])
    
    // For the "Ask" feature
    // Most of these answers were all stolen from Magic 8 ball
    // https://en.wikipedia.org/wiki/Magic_8-Ball
    //
    // Just a few were taken from Amanda's demonstration video
    // of Resolver
    //
    // TODO: Replace all with genuine Resolver answers
    static let askChoices = ChoiceList(choices:
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
    )
    
    
    // MARK: data file names
    static let currentChoicesFileName = "Choices.plist"
    
    
}