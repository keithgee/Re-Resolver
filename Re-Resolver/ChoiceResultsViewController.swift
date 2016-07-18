//
//  ChoiceResultsViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/13/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit
import AudioToolbox

// This ViewController selects and displays the answer
// from the "Decide", "Ask", and "Choose" features.
//
// Normal behavior is for the button title to be
// blank when the view loads, and for 
// button presses to select and display a new answer.
//
// Shaking the device will also display a new answer.
//
// If displayResultImmediately is set to
// true, the button title displays a result as
// soon as the view loads, and button presses
// and shaking are disabled.
class ChoiceResultsViewController: UIViewController {
    
    @IBOutlet private weak var choiceButton: UIButton!
    var choiceList: ChoiceList!                 // list of options from which to pick
    var menuTitle: String?                 // title for navigation bar
    var displayResultImmediately = false   // used in Choice feature
    
    @IBAction func choiceButtonPressed(button: UIButton) {
        
        button.setTitle(choiceList.choose(), forState: .Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        choiceButton.exclusiveTouch = true
        
        if let title = menuTitle  {
            navigationItem.title = title
        }
        
        if displayResultImmediately == true  {
    
            // Check that there are choices before displaying one!
            if choiceList.choices.count > 0  {
                choiceButton.setTitle(choiceList.choose(), forState: .Normal)
            }
            
            choiceButton.enabled = false
        } else  {
            becomeFirstResponder()
        }
        
    }
    
    // we don't enable shake events for "Choose" functionality,
    // but we do for other types
    override func canBecomeFirstResponder() -> Bool {
        return displayResultImmediately ? false : true
    }
    
    
    // When a shake is detected, pick a new answer (or potentially the same),
    // animate the label change, and then make the phone vibrate when the
    // animation is finished
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if !displayResultImmediately  {
            if motion == .MotionShake  && choiceList.choices.count > 0  {
                
                // Added an animation to give feedback that the shake was recognized.
                UIView.transitionWithView(choiceButton.titleLabel!, duration: 1.0, options: .TransitionFlipFromLeft,
                                          animations: {
                                            self.choiceButton.setTitle(self.choiceList.choose(), forState: .Normal)
                    }, completion: { wasSuccessful in
                        if wasSuccessful {
                            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                        }})
            }
        }
    }
}
