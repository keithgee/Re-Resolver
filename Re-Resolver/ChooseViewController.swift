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
// When the "Choose" button is pressed, another screen is displayed
// that shows a random selection from the table of choices.
class ChooseViewController: UIViewController,
UITableViewDataSource,
UITableViewDelegate,
NewChoiceDelegate {
    
    var choices =  [String]()
    
  
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        print("Documents folder is \(documentsDirectory())")
        print("Data file path is \(dataFilePath())")
        
        loadChoices()
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
    


    // Swipe to delete rows
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let choicesIndex = indexPath.row
            choices.removeAtIndex(choicesIndex)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            // save modified list to storage
            saveChoices()
            
            // disable the button if all choices were deleted
            if choices.count == 0  {
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
            resultsController.choices = choices
            resultsController.displayResultImmediately = true
            
        } else if segue.identifier == "AddChoice"  {  // Enter another choice
            let addChoiceController = segue.destinationViewController as! NewChoiceViewController
            
            addChoiceController.delegate = self
        }
        
    }
    

    
    // MARK: - NewChoiceDelegate
    // Used when choice added on the "New choice" screen
    func choiceAdded(choice: String) {
        
        let numberOfChoicesBeforeAddition = choices.count
        choices.append(choice)
       
        let indexPath = NSIndexPath(forRow: numberOfChoicesBeforeAddition, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        // write modified list to phone storage
        saveChoices()
        
        // make sure the choose button is enabled, as we now have at least 1 item
        chooseButton.enabled = true
        chooseButton.alpha = 1
        
    }
    
    // MARK: - Save and load choices
    // code here adapted from iOS Apprentice - Matthjis Hollemans
    func documentsDirectory() -> String  {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String  {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Choices.plist")
    }
    
    func saveChoices()  {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(choices, forKey: "Choices")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadChoices() {
        let path = dataFilePath()
        
        if NSFileManager.defaultManager().fileExistsAtPath(path)  {
            if let data = NSData(contentsOfFile: path)  {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                choices = unarchiver.decodeObjectForKey("Choices") as! [String]
            }
        }
    }

}
