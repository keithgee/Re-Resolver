//
//  RecentTableViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/15/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit

// TODO: Consider replacing with unwind segue
protocol RecentItemDelegate: class  {
    func recentItemSelected(_ item: String)
}

class RecentTableViewController: UITableViewController {

    // This allows the "New Choice" screen to get a recent choice
    weak var delegate: RecentItemDelegate?
    
    var choiceList = ChoiceList(choices: [String]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // support dynamic type
        // label is also configured with 0 rows,
        // body text style, word wrap, and automatically
        // resize in interface builder
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40.0
        
        choiceList.dataFileName = ResolverConstants.recentChoicesFileName
        choiceList.load()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choiceList.choices.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = choiceList.choices[(indexPath as NSIndexPath).row]
        return cell
    }
    

    // Handle taps on the rows by notifying the delegate of the text of the row
    // The delegate will also handle navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.recentItemSelected(choiceList.choices[(indexPath as NSIndexPath).row])
    }
    
    // Enable slide to delete on the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
            choiceList.choices.remove(at: (indexPath as NSIndexPath).row)
            try? choiceList.save()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
