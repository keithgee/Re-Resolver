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
// This controller acts as a delegate for the ChoiceDetailViewController,
// and updates the table when a new choice is entered or edited.
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
ChoiceDetailDelegate,
RecentItemDelegate {
    
    
    var choiceList: ChoiceList! // Current choices, as stored
                                // in the ResolverMenuViewController
    
    private var recentList = ChoiceList(choices: [String]())  // recent choices
    
    // TODO: Refactor
    // This is oddness because we are passing strings
    // to controllers. Strings are pass-by-value
    private var indexOfRowToEdit: Int?
  
    @IBOutlet private weak var chooseButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addChoiceButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prevent multiple items in navigation bar
        // from being pressed simultaneously, which
        // can corrupt the navigation stack
           navigationController?.navigationBar.isExclusiveTouch = true
        if let navigationBarViews = navigationController?.navigationBar.subviews  {
            for view in navigationBarViews  {
                view.isExclusiveTouch = true
            }
        }
        
        // allow rows to resize to accomodate multiple lines
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40.0
        
        // Adjust insets so that text on the custom
        // button appears centered.
        chooseButton.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 20.0, right: 0)
        
        // Use the original choose button image provided by
        // Fancy Pants Global if the app is using English.
        let preferredLocalization = Bundle.main.preferredLocalizations[0]
        if preferredLocalization.hasPrefix("en")  {
            chooseButton.setBackgroundImage(UIImage(named: "resolver_choose_button"), for: .normal)
            chooseButton.setBackgroundImage(UIImage(named: "resolver_choose_button_highlight"), for: .highlighted)
            chooseButton.setTitle("", for: .normal)
        }
        
        chooseButton.isExclusiveTouch = true
        
        // set the data file name for load/save recents functionality
        recentList.dataFileName = ResolverConstants.recentChoicesFileName
        recentList.load()
    }

   
    override func viewWillAppear(_ animated: Bool) {
        
        // it doesn't make sense to "Choose" when
        // we have entered any choices
        if choiceList.choices.count == 0 {
            chooseButton.isEnabled = false
            chooseButton.alpha = 0.2
        }
        
        addChoiceButton.isEnabled = true
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choiceList.choices.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "choiceCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = choiceList.choices[(indexPath as NSIndexPath).row]
        cell.textLabel?.textColor = .white
        return cell
    }
    


    // Swipe to delete rows
    // This deletes a row from the current choices table,
    // but leaves the row in the recent table
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let choicesIndex = (indexPath as NSIndexPath).row
            choiceList.choices.remove(at: choicesIndex)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // disable the button if all choices were deleted
            if choiceList.choices.count == 0  {
                chooseButton.isEnabled = false
                chooseButton.alpha = 0.2
            }
        }
    }
    
       
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "ChoiceResults"  {  // Show results after clicking "Choose" button
            let resultsController = segue.destination as! ChoiceResultsViewController
            resultsController.choiceList = choiceList
            resultsController.displayResultImmediately = true
            
        } else if segue.identifier == "AddChoice"  {  // Enter another choice
            
            // disable add button so that it can't be
            // pressed in quick succession
            addChoiceButton.isEnabled = false
            
            let addChoiceController = segue.destination as! ChoiceDetailViewController
         
            addChoiceController.delegate = self
        
        } else if segue.identifier == "EditChoice"  {  // edit current row when tapped
            
            let editChoiceController = segue.destination as! ChoiceDetailViewController
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)  {
                 editChoiceController.choiceToEdit = choiceList.choices[(indexPath as NSIndexPath).row]
                indexOfRowToEdit = (indexPath as NSIndexPath).row
            }
          
            editChoiceController.delegate = self
        }
        
    }
    
    // Add a new choice to the data model, the table,
    // and the recent list
    func addChoiceToList(_ choice: String)  {
        
        let numberOfChoicesBeforeAddition = choiceList.choices.count
        choiceList.choices.append(choice)
        
        // update current choices table
        let indexPath = IndexPath(row: numberOfChoicesBeforeAddition, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        // also update and save the recent list if necessary
        if !recentList.choices.contains(choice)  {
            recentList.choices.append(choice)
            try? recentList.save()
        }
        
        // make sure the choose button is enabled, as we now have at least 1 item
        chooseButton.isEnabled = true
        chooseButton.alpha = 1
    }

    
    // MARK: - ChoiceDetailDelegate
    
    // Used when choice added on the "New choice" screen
    func didFinishAddingChoice(_ choice: String) {
        _ = navigationController?.popViewController(animated: true)
        addChoiceToList(choice)
    }
    
    // Used when choice edited on the "New choice" screen
    // TODO: Refactor - fix duplicate code to save to recent
    // list = plus other cleanup.
    func didFinishEditingChoice(_ choice: String) {
        _ = navigationController?.popViewController(animated: true)
    
        let indexPath = IndexPath(row: indexOfRowToEdit!, section: 0)
        if tableView.cellForRow(at: indexPath) != nil  {
            choiceList.choices[indexOfRowToEdit!] = choice
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        indexOfRowToEdit = nil
        
        // also update and save the recent list if necessary
        if !recentList.choices.contains(choice)  {
            recentList.choices.append(choice)
            try? recentList.save()
        }
        
    }
    
    // MARK: RecentItemDelegate
    // Used when a choice is added from the "Recent" screen
    func recentItemSelected(_ item: String)  {
        _ = navigationController?.popToViewController(self, animated: true)
        addChoiceToList(item)
    }
    
    
}
