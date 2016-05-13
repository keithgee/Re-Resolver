//
//  ChooseViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/13/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit

// This controller handles the main "Choice" functionality
class ChooseViewController: UIViewController,
UITableViewDataSource,
UITableViewDelegate,
NewChoiceDelegate {
    
    var choices =  ["Pizza",
                    "Chinese",
                    "Other"]
    
  
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

   
    override func viewWillAppear(animated: Bool) {
        
        // it doesn't make sense to "Choose" when
        // we have entered any choices
        if choices.count == 0 {
            chooseButton.enabled = false
            chooseButton.alpha = 0.2
        }
    }
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("choiceCell", forIndexPath: indexPath)

        // Configure the cell...

        
        cell.textLabel?.text = choices[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Swipe to delete rows
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let choicesIndex = indexPath.row
            choices.removeAtIndex(choicesIndex)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            // disable the button if all choices were deleted
            if choices.count == 0  {
                chooseButton.enabled = false
                chooseButton.alpha = 0.2
            }
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ChoiceResults"  {
            let resultsController = segue.destinationViewController as! ChoiceResultsViewController
            
            resultsController.choices = choices
        } else if segue.identifier == "AddChoice"  {
            let addChoiceController = segue.destinationViewController as! NewChoiceViewController
            
            addChoiceController.delegate = self
        }

        
        
        
    }
    
    
    // MARK: NewChoiceDelegate
    // Used when choice added on the "New choice" screen
    func choiceAdded(choice: String) {
        
        let numberOfChoicesBeforeAddition = choices.count
        choices.append(choice)
       
        let indexPath = NSIndexPath(forRow: numberOfChoicesBeforeAddition, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        // make sure the choose button is enabled, as we now have at least 1 item
        chooseButton.enabled = true
        chooseButton.alpha = 1
        
    }
    

}
