//
//  FandangoViewController.swift
//  MovieViewer
//
//  Created by Nidhi Manoj on 6/17/16.
//  Copyright © 2016 Nidhi Manoj. All rights reserved.
//

import UIKit

class FandangoViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://www.fandango.com/"
        let requestURL = NSURL(string: url) // Convert the url String to a NSURL object.
        let request = NSURLRequest(URL: requestURL!) // Place the URL in a URL Request.
        webView.loadRequest(request) // Load the request into WebView.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
