//
//  ColorCollectionViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 9/17/17.
//  Copyright © 2017 Amanda and Keith. All rights reserved.
//

import UIKit


private let reuseIdentifier = "ColorCell"


// This controller is the replacement for the ColorTableViewController.
// It displays the color schemes in a collection view, using the
// ColorCollectionViewCell class.
//
// TODO: Understand cell lifecycle to understand precisely which code is needed
//       to handle selection, deselection, and redrawing of cell views
class ColorCollectionViewController: UICollectionViewController {

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let gradientBackground = ResolverGradientView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        collectionView!.backgroundView = gradientBackground
        adjustColorCellSize();

        
    }

    override func viewDidAppear(_ animated: Bool) {
        // Select currently configured color scheme when screen launches
        let colorNum = UserDefaults.standard.integer(forKey: "ColorPreference")
        if colorNum < ResolverConstants.colorList.count  {
            let indexPathOfCurrentColor = IndexPath(item: colorNum, section: 0)
            collectionView?.selectItem(at: indexPathOfCurrentColor, animated: true, scrollPosition: .centeredHorizontally)
            
            // reconfigure for "selected" style
            if let cell = collectionView?.cellForItem(at: indexPathOfCurrentColor) as? ColorCollectionViewCell {
                cell.configureFor(color: ResolverConstants.colorList[colorNum])
            }
        }
    }
    @IBAction func donePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ResolverConstants.colorList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ColorCollectionViewCell
    
        // Configure the cell
        let colorNum = indexPath.row
        if colorNum < ResolverConstants.colorList.count  {
            let color = ResolverConstants.colorList[colorNum]
            cell.configureFor(color: color)
        }
      
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
        if (indexPath as NSIndexPath).section == 0  {
            let colorNumber = (indexPath as NSIndexPath).row
            
            // Reconfigure cell with selected style
            if let cell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell  {
                cell.configureFor(color: ResolverConstants.colorList[colorNumber])
            }
            
            // get associated color components
            var selectedColor = ResolverConstants.colorList[0].colorComponents
            if colorNumber < ResolverConstants.colorList.count  {
                selectedColor = ResolverConstants.colorList[colorNumber].colorComponents
            }
            
            // update the background of the main selection view
            gradientBackground.colorComponents = selectedColor
            gradientBackground.setNeedsDisplay()
            
            // update the color scheme for all views allocated later
            appDelegate?.backgroundGradient = selectedColor
          
            // store color scheme as user preference
            UserDefaults.standard.set((indexPath as NSIndexPath).row, forKey: "ColorPreference")
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)  {
        
        // TODO: Fix
        // This is a workaround for when a selected cell is scrolled just
        // slightly off screen and remains in memory while another cell is selected.
        //
        // When the original cell appears on screen again, it looks to be in the selected state
        // with the thick border even though it has been deselected.
        //
        // This hack forces the cell to reload so the appearance will be different
        // when it appears on-screen again.
        // I suspect I am handling selection state/ selected appearance incorrectly.
        collectionView.reloadItems(at: [indexPath])
    }
    
    // This sets an appropriate size for color preview cells based on the
    // screen size of the device.
    // The height and width of the cells are scaled proportionally
    // so that the cells have an aspect ratio similar to the
    // entire screen.
    //
    // This configuration allows for a collection view of one row, with
    // portions of at least two color cells displaying on the screen at once.
    // This will be a cue to users that this screen is to be swiped
    // horizontally.
    // Prior to this change, multiple rows were appearing on simulations
    // of the 6.1 and 6.5 inch screens released in 2018, perhaps tempting
    // ineffective up/down swipes.
    //
    // Still problematic here:
    // If the user has the Dynamic Type settings on a very large text size,
    // the names of the colors spill over onto the next line, with breaks
    // in the middle of words. It looks bad.
    private func adjustColorCellSize()  {
        // The Layout type for this collection view has already been set to flowLayout in the storyboard
        if let flowLayout = collectionView!.collectionViewLayout as? UICollectionViewFlowLayout  {
            // get device dimensions
            let screenHeight = UIScreen.main.bounds.height
            let screenWidth = UIScreen.main.bounds.width
            
            // set cell dimensions accordingly
            let scaleFactor = CGFloat(0.618) // approximation of golden ratio, inverted
            let cellHeight = screenHeight * scaleFactor
            let cellWidth = screenWidth * scaleFactor
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        }
    }

}
