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
    // when instantiated via storyboards prior to iOS 11.
    // The storyboard for this scene has a generic UIView
    // in place to take advantage of the AutoLayout system,
    // while the main component of the scene, the WKWebView,
    // is sized to match this UIView and added as a subview.
    @IBOutlet weak var enclosingView: UIView!
    var webView: WKWebView! // implicit unwrap seems risky here
    
    
    // Create and configure the WKWebView and load localized help
    // text.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This could have been done in the storyboard, but
        // I wanted the view to be visible on the board.
        enclosingView.backgroundColor = UIColor.clear
    
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.javaScriptEnabled = false
        webView = WKWebView(frame: enclosingView.frame, configuration: webConfiguration)
    
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        view.addSubview(webView)

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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = enclosingView.frame
    }

    // Load links in the about page in the Safari app, instead of the
    // WebView. This avoids the following problems and work:
    //    1. App Transport Security issues with http websites
    //    2. Need to add and program navigation buttons for the webview
    //
    //   There was a problem with VoiceOver when connecting to the GitHub
    //   link in the initial test.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == .linkActivated  {
            UIApplication.shared.openURL(navigationAction.request.url!)
            decisionHandler(.cancel)
        } else  {
            decisionHandler(.allow)
        }
    }
    
}
