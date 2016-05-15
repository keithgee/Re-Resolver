//
//  RecentTableViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/15/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit

protocol RecentItemDelegate  {
    func recentItemSelected(item: String)
}

class RecentTableViewController: UITableViewController {

    // This allows the "New Choice" screen to get a recent choice
    var delegate: RecentItemDelegate?
    
    var choiceList = ChoiceList(choices: [String]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        choiceList.dataFileName = ResolverConstants.recentChoicesFileName
        choiceList.load()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choiceList.choices.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecentCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = choiceList.choices[indexPath.row]
        return cell
    }
    

    // Handle taps on the rows by notifying the delegate of the text of the row
    // and then popping back to the previous screen
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.recentItemSelected(choiceList.choices[indexPath.row])
        navigationController?.popViewControllerAnimated(true)
    }
    
    // Enable slide to delete on the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            choiceList.choices.removeAtIndex(indexPath.row)
            choiceList.save()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
}