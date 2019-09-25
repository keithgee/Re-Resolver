//
//  ReResolverUITests.swift
//  ReResolverUITests
//
//  Created by Keith Gilbertson on 12/18/17.
//  Copyright © 2017 Amanda and Keith. All rights reserved.
//

import XCTest

// TODO: Some of these tests will fail if the test
//       scheme is set to a language other than English.
//       Fix.
class ReResolverUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens
        // for each test method.
        // This seems to install the app fresh after each test. Not sure if that's what I want.
        // App will be in a known state, but this is slow.  --Keith
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        super.tearDown()
    }
    
    // Test the "Decide" functionality
    func testDecideScreen()  {
        
        app.buttons["Decide"].tap()
        let resultsButton = app.buttons["Results"]
        resultsButton.tap()
        
        // verify that the Results button contains yes or no
        XCTAssert(app.buttons["Yes"].exists || app.buttons["No"].exists)
        
        app.navigationBars["Decide"].buttons["Menu"].tap()
        
        // verify that we're back on the main screen
        XCTAssert(app.buttons["Decide"].exists && app.buttons["Choose"].exists && app.buttons["Ask"].exists)
        
    }
    
    // Test the "Ask" functionality
    func testAskScreen()  {
        
        app.buttons["Ask"].tap()
        let resultsButton = app.buttons["Results"]
        resultsButton.tap()
        
        // Verify that the Results button has a valid response, according to the "Ask" answers
        let choices = ResolverConstants.askChoices.choices
        var foundValidResponse = false
        for choice in choices  {
            if app.buttons[choice].exists  {
                foundValidResponse = true
                break
            }
        }
        XCTAssert(foundValidResponse)
        
        app.navigationBars["Ask"].buttons["Menu"].tap()
        
        // verify that we're back on the main screen
        XCTAssert(app.buttons["Decide"].exists && app.buttons["Choose"].exists && app.buttons["Ask"].exists)
    }
    
    // Test the "Choose" functionality.
    // This a bit confusing because there is a button on the main menu
    // named "Choose", and a button on the Choose screen also called "Choose"
    //
    // This function:
    //    1. adds a list of 5 pets to the choices
    //    2. Taps the choice button
    //    3. verifies that the result is from the list of pets
    //    4. Goes to the recent screen and adds "Fish" again
    //    5. Checks that "Fish" is now the sixth row in the list of choices
    func testChooseScreen()  {
        let mainMenuChooseButton = app.buttons["Choose"]
        mainMenuChooseButton.tap()
        
        let addButton = app.navigationBars["Choose"].buttons["Add"]
        let choiceTextField = app.textFields["Choice"]
        
        let petChoices = ["Cat", "Dog", "Bird"]
        for pet in petChoices  {
            addButton.tap()
            choiceTextField.typeText(pet + "\r")
        }
        
        let choiceScreenChooseButton = app.buttons["Choose"]
        choiceScreenChooseButton.tap()
        
        // Check that the result is in our petChoices list
        var foundValidResponse = false
        for choice in petChoices  {
            if app.buttons[choice].exists  {
                foundValidResponse = true
                break
            }
        }
        XCTAssert(foundValidResponse)
        
        app.navigationBars["ReResolver.ChoiceResultsView"].buttons["Choose"].tap()
        // verify that we're back on the choose screen
        XCTAssert(addButton.exists)
        
        // Go into the recent screen and select "Dog"
        app.navigationBars["Choose"].buttons["Add"].tap()
        app.navigationBars["New Choice"].buttons["Recent"].tap()
        let dogStaticText = app.tables.staticTexts["Dog"]
        dogStaticText.tap()
        
        // verify that the fourth row on the Choice screen is "Dog"
        XCTAssert(app.tables.children(matching: .cell).element(boundBy: 3).staticTexts["Dog"].exists)
       
        app.navigationBars["Choose"].buttons["Menu"].tap()
        // verify that we're back on the main screen
        XCTAssert(app.buttons["Decide"].exists && app.buttons["Choose"].exists && app.buttons["Ask"].exists)
    }
    
    
    // MARK: Stubs.
    // Test below this line tap a few things
    // on their respective screens, but they don't verify functionality.
    func testInformationScreen()  {
        
        app.buttons["More Info"].tap()
        // TODO: Check that the instructions load!
        app.navigationBars["Information"].buttons["Menu"].tap()
        
    }
    
    func testSelectColor()  {
        // TODO: Verify that colors changed properly
        
        // Change the color to "Crimson"
        app.buttons["Set Colors"].tap()
        var collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"Crimson").element.tap()
        app.navigationBars["Select Color"].buttons["Done"].tap()
        
        // Change the color to "Dark Calm"
        app.buttons["Set Colors"].tap()
        collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"Dark Calm").element.tap()
        app.navigationBars["Select Color"].buttons["Done"].tap()
        
    }
}
