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

    let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    
    var colorComponents: [CGFloat]?
    
    
    override func drawRect(rect: CGRect) {
       
        if colorComponents == nil  {
            if let appDelegate = appDelegate {
                colorComponents = appDelegate.backgroundGradient
            } else {
                colorComponents = ResolverConstants.darkCalm
            }
        }
        let locations: [CGFloat] = [0, 1]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents!, locations, 2)
        
        
        let context = UIGraphicsGetCurrentContext()

        // The gradient is diagonal, from dark in the top left corner
        // to lighter in the bottom right
        let startPoint = CGPoint(x: CGRectGetMinX(bounds), y: CGRectGetMinY(bounds))
        let endPoint = CGPoint(x: CGRectGetMaxX(bounds), y: CGRectGetMaxY(bounds))
        
        CGContextDrawLinearGradient(context,
                                    gradient,
                                    startPoint,
                                    endPoint,
                                    .DrawsAfterEndLocation)
      

    }
    

}
