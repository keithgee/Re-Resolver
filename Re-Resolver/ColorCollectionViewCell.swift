//
//  ColorCollectionViewCell.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 9/17/17.
//  Copyright © 2017 Amanda and Keith. All rights reserved.
//

import UIKit

// This configures the collection view cell with a color scheme,
// using the gradient of the color scheme as the cell background,
// and labeling the cell with the name of the color scheme
//
// The border of the cell is white, and thicker if selected.
//
// The prototype cell is in the storyboard.
class ColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorNameLabel: UILabel!
    
    func configureFor(color: ResolverConstants.ColorScheme)  {
        let gradientView = ResolverGradientView(frame: frame)
        gradientView.colorComponents = color.colorComponents
        backgroundView = gradientView
        colorNameLabel.text = color.colorName
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = isSelected ? 6 : 1
        
    }
    
    // TODO: This may no longer be necessary
    override func prepareForReuse() {
        super.prepareForReuse()
        layer.borderWidth = 1
    }
    
}
