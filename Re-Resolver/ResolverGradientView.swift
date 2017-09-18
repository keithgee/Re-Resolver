//
//  ResolverGradientView.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/13/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit

// This view makes a black to gray gradient on the screen.
// It's meant to emulate some of the color texture in the original
// Resolvr. 
//
// An alternative could be to use images
//
// TODO: Make an actually usable interface
// to set the color gradients.
//
// TODO: Fix coupling of this class
//       to Resolver app delegate. Class
//       should be reusable.
@IBDesignable
class ResolverGradientView: UIView {

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var colorComponents: [CGFloat]?
    
    
    override func draw(_ rect: CGRect) {
       
        if colorComponents == nil  {
            if let appDelegate = appDelegate {
                colorComponents = appDelegate.backgroundGradient
            } else {
                colorComponents = ResolverConstants.colorList[0].colorComponents
            }
        }
        let locations: [CGFloat] = [0, 1]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colorComponents!, locations: locations, count: 2)
        
        
        let context = UIGraphicsGetCurrentContext()

        // The gradient is diagonal, from dark in the top left corner
        // to lighter in the bottom right
        let startPoint = CGPoint(x: bounds.minX, y: bounds.minY)
        let endPoint = CGPoint(x: bounds.maxX, y: bounds.maxY)
        
        context?.drawLinearGradient(gradient!,
                                    start: startPoint,
                                    end: endPoint,
                                    options: .drawsAfterEndLocation)
      

    }
    

}
