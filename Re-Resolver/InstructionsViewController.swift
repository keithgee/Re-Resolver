//
//  InstructionsViewController.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/15/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import UIKit


// This class is the controller for the instructions
// page.
class InstructionsViewController: UIViewController, UIWebViewDelegate {

    // TODO: UIWebView is deprecated. Replace with WKWebView or
    // SafariViewController. Note: WKWebView may have problems
    // when instantiated via storyboards prior to iOS 11.
    // SafariViewController may (I don't know yet) be difficult
    // to customize with translucent background rendering to match
    // the look of the rest of the app.
    
    @IBOutlet weak var webView: UIWebView!
    
    // Load internationalized help text into the webview.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        // get the preferred language. This should be more flexible,
        // but at present the only localizations are English and Spanish.
        var languageCode = "en"
        let preferredLocalization = Bundle.main.preferredLocalizations[0]
        if preferredLocalization.hasPrefix("es")  {
           languageCode = "es"
        }
        
        if let url = Bundle.main.url(forResource: "information_" + languageCode, withExtension: "html")  {
            if let htmlData = try? Data(contentsOf: url )  {
                let baseUrl = URL(fileURLWithPath: Bundle.main.bundlePath)
                webView.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseUrl)
            }
        }
     
    }
    
    
    // Load links in the about page in the Safari app, instead of the
    // WebView. This avoids the following problems and work:
    //    1. App Transport Security issues with http websites
    //    2. Need to add and program navigation buttons for the webview
    //
    //   There was a problem with VoiceOver when connecting to the GitHub
    //   link in the initial test.
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if navigationType == UIWebViewNavigationType.linkClicked {
            UIApplication.shared.openURL(request.url!)
            return false
        }
      
        return true
    }
   
}
