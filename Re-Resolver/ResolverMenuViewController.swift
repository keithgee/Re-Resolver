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

    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    
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
        
        decideButton.isExclusiveTouch = true
        chooseButton.isExclusiveTouch = true
        askButton.isExclusiveTouch = true
        
        // The original image assets provided by Fancy Pants
        // Global have English text saved as part of the image.
        // If the device is using English, use the original assets
        // and blank the text labels.
        let preferredLocalization = Bundle.main.preferredLocalizations[0]
        if preferredLocalization.hasPrefix("en")  {
            decideButton.setBackgroundImage(UIImage(named: "resolver_decide_button"), for: .normal)
          decideButton.setBackgroundImage(UIImage(named:"resolver_decide_button_highlight"), for: .highlighted)
            decideButton.setTitle("", for: .normal)
            
            chooseButton.setBackgroundImage(UIImage(named: "resolver_choose_button"), for: .normal)
            chooseButton.setBackgroundImage(UIImage(named: "resolver_choose_button_highlight"), for: .highlighted)
            chooseButton.setTitle("", for: .normal)
            
            askButton.setBackgroundImage(UIImage(named: "resolver_ask_button"), for: .normal)
            askButton.setBackgroundImage(UIImage(named: "resolver_ask_button_highlight"), for: .highlighted)
            askButton.setTitle("", for: .normal)

        } else  { // a supported language other than English (currently, Spanish)
            
            // Adjust insets so that text on the custom
            // buttons appears centered. This step was
            // required after i18n and applies only
            // to languages other than English.
            //
            decideButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 20.0, 0)
            chooseButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 20.0, 0)
            askButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 20.0, 0)
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // kind of ugly here. still not sure how to make
        // color code nice
    
        if let gradientView = view as? ResolverGradientView  {
            gradientView.colorComponents = appDelegate?.backgroundGradient
            gradientView.setNeedsDisplay()
        }
    }
   
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DecideSegue"  {
            let choiceResultsController = segue.destination as! ChoiceResultsViewController
            choiceResultsController.menuTitle = NSLocalizedString("Decide", comment: "Name of Decide Menu Title")
            choiceResultsController.choiceList = ResolverConstants.decideChoices
            
        }  else if segue.identifier == "AskSegue"  {
            let choiceResultsController = segue.destination as! ChoiceResultsViewController
            choiceResultsController.menuTitle = NSLocalizedString("Ask", comment: "Name of Ask Menu Title")
            choiceResultsController.choiceList = ResolverConstants.askChoices
        }
        else if segue.identifier == "ChooseSegue"  {
            
            // inject any saved choices into the table on the "Choose" screen
            let chooseController = segue.destination as! ChooseViewController
            chooseController.choiceList = choices
        }
        
        
    }
}

