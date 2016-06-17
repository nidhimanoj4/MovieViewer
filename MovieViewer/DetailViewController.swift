//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by Nidhi Manoj on 6/16/16.
//  Copyright © 2016 Nidhi Manoj. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let title = movie["title"] as? String
        titleLabel.text = title
        let overview = movie["overview"] as? String
        overviewLabel.text = overview
        
        let baseURL = "http://image.tmdb.org/t/p/w500"
        if let poster_path = movie["poster_path"] as? String { //poster_path not NILL
            let posterURL = NSURL(string: baseURL + poster_path)
            // set Image using cocoa pods function setImageWithURL
            posterImageView.setImageWithURL(posterURL!)
        }
        
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
