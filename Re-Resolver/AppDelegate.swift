//
//  AppDelegate.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/13/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var backgroundGradient = ResolverConstants.colorList[0].colorComponents


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // use custom bar button image
        let barButtonAppearance = UIBarButtonItem.appearance()
        let backImage = UIImage(named: "navbar_button")
        barButtonAppearance.setBackButtonBackgroundImage(backImage, for: UIControlState(), barMetrics: .default  )
        
        // If this app is running on iOS 11 or higher,
        // fix an apparent iOS bug where the "<" indicator
        // is shown on custom back buttons in navigation bars
        // This code may need to be updated if this is determined
        // to be an iOS bug and it is fixed in later updates.
        if #available (iOS 11.0, *)  {
            self.hideNavBarDefaultBackIndicator()
        }
        
        // register defaults for background gradient
        let dictionary = ["ColorPreference": 0]
        UserDefaults.standard.register(defaults: dictionary)
        
        let colorPreference = UserDefaults.standard.integer(forKey: "ColorPreference")
        if colorPreference < ResolverConstants.colorList.count  {
            backgroundGradient = ResolverConstants.colorList[colorPreference].colorComponents
        } else {
            backgroundGradient = ResolverConstants.colorList[0].colorComponents
        }
        
        return true
    }

    // This is used only in iOS 11 and higher to work around
    // a bug that displays the default "<" back indicator
    // in navigation bars even when a custom button image is
    // used.
    func hideNavBarDefaultBackIndicator()  {
        // hide default "<" image
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.backIndicatorImage = UIImage()
        navBarAppearance.backIndicatorTransitionMaskImage = UIImage()
        
        // adjust text label on the custom back button so that it
        // isn't smashed up to the left side of the display.
        let buttonTitleAdjustment = UIOffsetMake(-20,0)
        let barButtonAppearance = UIBarButtonItem.appearance()
        barButtonAppearance.setBackButtonTitlePositionAdjustment(buttonTitleAdjustment, for: .default)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

