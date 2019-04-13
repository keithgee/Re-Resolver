//
//  ReResolverTests.swift
//  ReResolverTests
//
//  Created by Keith Gilbertson on 11/17/18.
//  Copyright © 2018 Amanda and Keith. All rights reserved.
//

import XCTest
@testable import ReResolver

class ChoiceListTests: XCTestCase {


    func testChooseFromEmptyList() {
        // Making a selection from an empty ChoiceList should return
        // an empty String (and not nil)
        
        let choiceList = ChoiceList(choices: [String]())
        let choice = choiceList.choose()
        
        XCTAssertNotNil(choice, "Choosing from an empty list unexpectedly returned nil.")
        XCTAssertEqual("", choice, "Choosing from an empty list did not return an empty string.")
        
    }

    func testChooseFromOneOption()  {
        let choiceList = ChoiceList(choices: ["Choice 1"])
        let choice = choiceList.choose()
        
        XCTAssertEqual("Choice 1", choice, "Choosing from one option failed")
    }


    func testChooseFromTwoOptions()  {
        
        // check that picking from two options will properly select one of the options
        let twoChoices = ["Choice 1", "Choice 2"]
        let choiceList = ChoiceList(choices: twoChoices)
        var choice = choiceList.choose()
        XCTAssert(twoChoices.contains(choice), "Choosing from two options gave an unexpected result")
        
        
        // check that both options will be selected over time
        // This test could fail even if the code is
        // working correctly. It's possible (but very unlikely)
        // for the same choice to be selected 100 times in a row
        let firstChoice = choice
        for _ in 1...100  {
            choice = choiceList.choose()
            if choice != firstChoice  {
                break
            }
        }
        XCTAssertNotEqual(firstChoice, choice, "Selecting from two options 100 times picked the same option each time")
    }
    
    // TODO: check that the distribution
    // from a large number of selections is approximately equal

    // TODO: Test file reads and writes


}
