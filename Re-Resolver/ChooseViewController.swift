//
//  ChooseViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/13/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit

// This controller handles the main Choice functionality
//
// It displays a table with all of the choices in it.
// This controller acts as a delegate for the NewChoiceViewController,
// and updates the table when a new choice is entered on that screen.
//
// The controller also acts as a delegate for the "Recent" controller
// and similarly updates the table with the choice selected from the
// Recent table.
//
// When the "Choose" button is pressed, another screen is displayed
// that shows a random selection from the table of choices.
class ChooseViewController: UIViewController,
UITableViewDataSource,
UITableViewDelegate,
NewChoiceDelegate,
RecentItemDelegate {
    
    
    var choiceList =  ChoiceList(choices: [String]()) // current choices
    private var recentList = ChoiceList(choices: [String]())  // recent choices
  
    @IBOutlet private weak var chooseButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var addChoiceButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prevent multiple items in navigation bar
        // from being pressed simultaneously, which
        // can corrupt the navigation stack
           navigationController?.navigationBar.exclusiveTouch = true
        if let navigationBarViews = navigationController?.navigationBar.subviews  {
            for view in navigationBarViews  {
                view.exclusiveTouch = true
            }
        }
        
        chooseButton.exclusiveTouch = true
        
        // set the data file name for load/save recents functionality
        recentList.dataFileName = ResolverConstants.recentChoicesFileName
        recentList.load()
    }

   
    override func viewWillAppear(animated: Bool) {
        
        // it doesn't make sense to "Choose" when
        // we have entered any choices
        if choiceList.choices.count == 0 {
            chooseButton.enabled = false
            chooseButton.alpha = 0.2
        }
        
        addChoiceButton.enabled = true
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choiceList.choices.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("choiceCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = choiceList.choices[indexPath.row]
        return cell
    }
    


    // Swipe to delete rows
    // This deletes a row from the current choices table,
    // but leaves the row in the recent table
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let choicesIndex = indexPath.row
            choiceList.choices.removeAtIndex(choicesIndex)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            // disable the button if all choices were deleted
            if choiceList.choices.count == 0  {
                chooseButton.enabled = false
                chooseButton.alpha = 0.2
            }
        }
    }
    
       
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "ChoiceResults"  {  // Show results after clicking "Choose" button
            let resultsController = segue.destinationViewController as! ChoiceResultsViewController
            resultsController.choiceList = choiceList
            resultsController.displayResultImmediately = true
            
        } else if segue.identifier == "AddChoice"  {  // Enter another choice
            
            // disable add button so that it can't be
            // pressed in quick succession
            addChoiceButton.enabled = false
            
            let addChoiceController = segue.destinationViewController as! NewChoiceViewController
         
            addChoiceController.delegate = self
        }
        
    }
    
    // Add a new choice to the data model, the table,
    // and the recent list
    func addChoiceToList(choice: String)  {
        
        let numberOfChoicesBeforeAddition = choiceList.choices.count
        choiceList.choices.append(choice)
        
        // update current choices table
        let indexPath = NSIndexPath(forRow: numberOfChoicesBeforeAddition, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        // also update and save the recent list if necessary
        if !recentList.choices.contains(choice)  {
            recentList.choices.append(choice)
            recentList.save()
        }
        
        // make sure the choose button is enabled, as we now have at least 1 item
        chooseButton.enabled = true
        chooseButton.alpha = 1
    }

    
    // MARK: - NewChoiceDelegate
    // Used when choice added on the "New choice" screen
    func choiceAdded(choice: String) {
        
        navigationController?.popViewControllerAnimated(true)
        addChoiceToList(choice)
        
    }
    
    // MARK: RecentItemDelegate
    // Used when a choice is added from the "Recent" screen
    func recentItemSelected(item: String)  {
        navigationController?.popToViewController(self, animated: true)
        addChoiceToList(item)
    }
    
    
}
