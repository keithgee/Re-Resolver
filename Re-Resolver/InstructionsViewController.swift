//
//  InstructionsViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/15/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit
import WebKit

// This class is the ViewController for the instructions
// page.
class InstructionsViewController: UIViewController, WKNavigationDelegate {

    // Note: WKWebView may have problems
    // when instantiated via storyboards prior to iOS 11,
    // but at the time of this writing, the app still functions
    // under iOS 9.3. Therefore the WKWebView is added from this code
    // instead of the storyboard.
    //
    // The storyboard for this scene has a generic UIView (enclosingView)
    // in place to take advantage of the AutoLayout system,
    // while the main component of the scene, the WKWebView,
    // is added as a subview and sized to fit in viewDIdLayoutSubviews.
    @IBOutlet weak var enclosingView: UIView!
    let webView = WKWebView()
    
    // Create and configure the WKWebView and load localized help
    // text.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This could have been done in the storyboard, but
        // I wanted the enclosingView to be visible in Interface Builder.
        enclosingView.backgroundColor = UIColor.clear
    
        // Configure the webView
        webView.configuration.preferences.javaScriptEnabled = false
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        enclosingView.addSubview(webView)
        webView.navigationDelegate = self
        
        // Get the preferred language. This should be more flexible,
        // but at present the only localizations are English and Spanish.
        var languageCode = "en"
        let preferredLocalization = Bundle.main.preferredLocalizations[0]
        if preferredLocalization.hasPrefix("es")  {
           languageCode = "es"
        }
      
        if let url = Bundle.main.url(forResource: "information_" + languageCode, withExtension: "html")  {
            webView.loadFileURL(url, allowingReadAccessTo: url)
        }
    }

    // Overridden to set the webView to fill
    // the bounds of the enclosingView after
    // layout constraints have been applied
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame =
            CGRect(x: 0.0, y: 0.0, width: enclosingView.frame.width, height: enclosingView.frame.height)
    }

    // Load links in the about page in the Safari app, instead of the
    // WKWebView. This avoids the following problems and work:
    //    1. App Transport Security issues with http websites
    //    2. Need to add and program navigation buttons for the webview
    //    3. Inconsistencies with previous versions of the app
    //
    //   TODO: Test with VoiceOver. There was a problem with VoiceOver when connecting to the GitHub
    //   link in the initial test that used UIWebView instead of WKWebView.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == .linkActivated  {
            UIApplication.shared.openURL(navigationAction.request.url!)
            decisionHandler(.cancel)
        } else  {
            decisionHandler(.allow)
        }
    }
}
