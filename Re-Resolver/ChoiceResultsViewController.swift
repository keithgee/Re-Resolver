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
// soon as the view loads. This is used in the
// "Choice" feature.
class ChoiceResultsViewController: UIViewController {
    
    @IBOutlet private weak var choiceButton: UIButton!
    var choiceList: ChoiceList!                 // list of options from which to pick
    var menuTitle: String?                 // title for navigation bar
    var displayResultImmediately = false   // used in Choice feature
    
    @IBAction func choiceButtonPressed(button: UIButton) {
        
        let choice = choiceList.choose()
        button.setTitle(choice, forState: .Normal)
        choiceButton.accessibilityLabel = choice
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        choiceButton.exclusiveTouch = true
        
        // center each line in the label, as in the original Resolver
        choiceButton.titleLabel?.textAlignment = .Center
        
        if let title = menuTitle  {
            navigationItem.title = title
        }
        
        if displayResultImmediately == true  {
    
            // Check that there are choices before displaying one!
            if choiceList.choices.count > 0  {
                let choice =  choiceList.choose()
                choiceButton.setTitle(choice, forState: .Normal)
                choiceButton.accessibilityLabel = choice
            }
        }
        
        becomeFirstResponder()
        
    }
    
    // Let this controller respond to shake events
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    
    // When a shake is detected, pick an answer again,
    // animate the label change, and then make the phone vibrate when the
    // animation is finished
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if motion == .MotionShake  && choiceList.choices.count > 0  {
                
                // Added an animation to give feedback that the shake was recognized.
                UIView.transitionWithView(choiceButton.titleLabel!, duration: 0.5, options: .TransitionFlipFromLeft,
                                          animations: {
                                            let choice = self.choiceList.choose()
                                            self.choiceButton.setTitle(choice, forState: .Normal)
                                            self.choiceButton.accessibilityLabel = choice
                                            
                                            // If VoiceOver is enabled, speak the new result
                                            UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, choice)
                    }, completion: { animationWasSuccessful in
                        if animationWasSuccessful {
                            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                        }} )
            }
        
    }
}
