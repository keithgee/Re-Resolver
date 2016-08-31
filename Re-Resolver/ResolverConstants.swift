//
//  ResolverConstants.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/15/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import Foundation
import UIKit  // For CGFloat

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
    static let askChoices = ChoiceList(choices:
           [
            
            // Below are genuine Resolver answers
            "According to my manual, Yes.",
            "According to NASA the answer is no.",
            "As far as I can tell, yes.",
            "Can you ask later. My circuits are having a bad day.",
            "Chance of positive outcome: 93.487%",
            "I need to think about this a bit longer.",
            "I wouldn't bet on it.",
            "I'm not sure. Check again later.",
            "It's looking good.",
            "No Way Jose, your name is Jose, right?!?",
            "Nope, Sorry!",
            "Oh Yeah!",
            "Only time will tell, so why should I bother?",
            "Sure, when pigs fly.",
            "Surely you can't be serious?",
            "System Error. Please try again!",
            "That's a negative.",
            "What kind of a question is that?",
            "Yes.",
            "You can't expect me to answer that now.",
            
        ]
    )
    
    
    // MARK: data file names
    static let recentChoicesFileName = "Recent.plist"
    
    
    // MARK: Color schemes
    static let darkCalm: [CGFloat] = [
        0.02, 0.02, 0.02, 1,   // almost black
        0.3, 0.3, 0.3, 1]   //  gray

    static let crimson: [CGFloat] =  [
         0.02, 0.0, 0.0, 1,
         0.3, 0.0, 0.0, 1]
    
    static let clover: [CGFloat] = [
        0.0, 0.02, 0.0, 1,
        0.0, 0.3, 0.0, 1]
    
    static let ocean: [CGFloat] = [
        0.0, 0.0, 0.3, 1,
        0.0, 0.4, 0.3, 1]
    
    static let passion: [CGFloat] = [
        0.8, 0.0, 0.0, 1,
        0.0, 0.0, 0.8, 1]
    
}