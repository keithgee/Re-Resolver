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
    static let decideChoices = ChoiceList(choices:
        [
            NSLocalizedString("Yes", comment: "Affirmative on Decide Screen"),
            NSLocalizedString("No", comment: "Negative on Decide Screen")])
    
    // For the "Ask" feature
    static let askChoices = ChoiceList(choices:
           [
            
            // Below are genuine Resolver answers
            NSLocalizedString("According to my manual, Yes.", comment: "Answer on ask screen"),
            NSLocalizedString("According to NASA the answer is no.", comment: "Answer on ask screen"),
            NSLocalizedString("As far as I can tell, yes.", comment: "Answer on ask screen"),
            NSLocalizedString("Can you ask later. My circuits are having a bad day.", comment: "Answer on ask screen"),
            NSLocalizedString("Chance of positive outcome: 93.487%", comment: "Answer on ask screen"),
            NSLocalizedString("I need to think about this a bit longer.", comment: "Answer on ask screen"),
            NSLocalizedString("I wouldn't bet on it.", comment: "Answer on ask screen"),
            NSLocalizedString("I'm not sure. Check again later.", comment: "Answer on ask screen"),
            NSLocalizedString("It's looking good.", comment: "Answer on ask screen"),
            NSLocalizedString("No Way Jose, your name is Jose, right?!?", comment: "Answer on ask screen"),
            NSLocalizedString("Nope, Sorry!", comment: "Answer on ask screen"),
            NSLocalizedString("Oh Yeah!", comment: "Answer on ask screen"),
            NSLocalizedString("Only time will tell, so why should I bother?", comment: "Answer on ask screen"),
            NSLocalizedString("Sure, when pigs fly.", comment: "Answer on ask screen"),
            NSLocalizedString("Surely you can't be serious?", comment: "Answer on ask screen"),
            NSLocalizedString("System Error. Please try again!", comment: "Answer on ask screen"),
            NSLocalizedString("That's a negative.", comment: "Answer on ask screen"),
            NSLocalizedString("What kind of a question is that?", comment: "Answer on ask screen"),
            NSLocalizedString("Yes.", comment: "Answer on ask screen"),
            NSLocalizedString("You can't expect me to answer that now.", comment: "Answer on ask screen"),
            
        ]
    )
    
   
    // MARK: data file names
    static let recentChoicesFileName = "Recent.plist"
    
    
    // MARK: Color schemes
    
    // each color has a name and a gradient
    // To add a new color scheme, add the data to the colorList array
    // and optionally, put a translation in Localizable.strings
    struct ColorScheme  {
        let colorName: String
        let colorComponents: [CGFloat]
    }
    
    // TODO: Assign names to color scheme constants before adding to array.
    // Would an enumeration be appropriate?
    
    // TODO: consider moving color schemes out of this file and into ResolverGradientView
    static let colorList = [
        ColorScheme(colorName: NSLocalizedString("Dark Calm", comment: "dark gray black scheme"),
                    colorComponents:
            [0.02, 0.02, 0.02, 1,   // almost black
             0.3, 0.3, 0.3, 1]   //  gray)
            ),
        ColorScheme(colorName: NSLocalizedString("Crimson",comment: "red color scheme"),
                    colorComponents:
            [0.02, 0.0, 0.0, 1,
              0.3, 0.0, 0.0, 1]
        ),
        ColorScheme(colorName: NSLocalizedString("Clover", comment: "green color scheme"),
                    colorComponents:
            [0.0, 0.02, 0.0, 1,
             0.0, 0.3, 0.0, 1]
        ),
        ColorScheme(colorName: NSLocalizedString("Ocean", comment: "blue green color scheme"),
                    colorComponents:
            [0.0, 0.0, 0.3, 1,
             0.0, 0.4, 0.3, 1]
        ),
        ColorScheme(colorName: NSLocalizedString("Passion", comment: "pink and purple red blue color scheme"),
                    colorComponents:
            [0.8, 0.0, 0.0, 1,
             0.0, 0.0, 0.8, 1]
        ),
        ColorScheme(colorName: NSLocalizedString("Through Kate's Eyes", comment: "orange-red color scheme"),
                    colorComponents:
            [0.95, 0.10, 0.10, 1,
             0.96, 0.90, 0.46, 1] // Bornstein's glasses
        ),
        ColorScheme(colorName: NSLocalizedString("Midnight", comment: "Pure black for OLED displays"),
                    colorComponents: 
            [0.0, 0.0, 0.0, 1,
             0.0, 0.0, 0.0, 1]    // This is a hack, as the theming system was designed for gradients
        ),
    ]
}
