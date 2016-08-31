//
//  ColorTableViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 7/25/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit

class ColorTableViewController: UITableViewController {

    
    let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    
    @IBOutlet weak var darkCalmView: ResolverGradientView!
    @IBOutlet weak var crimsonView: ResolverGradientView!
    @IBOutlet weak var cloverView: ResolverGradientView!
    @IBOutlet weak var oceanView: ResolverGradientView!
    @IBOutlet weak var passionView: ResolverGradientView!
    @IBOutlet weak var bornsteinView: ResolverGradientView!
    
    @IBOutlet weak var previewArea: ResolverGradientView!
    
    
    @IBAction func donePressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        darkCalmView.colorComponents = ResolverConstants.darkCalm
        crimsonView.colorComponents = ResolverConstants.crimson
        cloverView.colorComponents = ResolverConstants.clover
        oceanView.colorComponents = ResolverConstants.ocean
        passionView.colorComponents = ResolverConstants.passion
        bornsteinView.colorComponents = ResolverConstants.bornstein
     
    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0  {
            return 6
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0  {
            switch indexPath.row {
            case 0:
            previewArea.colorComponents = ResolverConstants.darkCalm
            case 1:
                previewArea.colorComponents = ResolverConstants.crimson
            case 2:
                previewArea.colorComponents = ResolverConstants.clover
            case 3:
                previewArea.colorComponents = ResolverConstants.ocean
            case 4:
                previewArea.colorComponents = ResolverConstants.passion
            case 5:
                previewArea.colorComponents = ResolverConstants.bornstein
            default:
                previewArea.colorComponents = ResolverConstants.darkCalm
            }
            
            appDelegate?.backgroundGradient = previewArea.colorComponents!
            previewArea.setNeedsDisplay()
            NSUserDefaults.standardUserDefaults().setInteger(indexPath.row, forKey: "ColorPreference")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 1  {
            return 200
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
   }
