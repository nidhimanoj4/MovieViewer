//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Nidhi Manoj on 6/15/16.
//  Copyright © 2016 Nidhi Manoj. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD




class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary]?
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl after the new data has been pulled from the network request
    func refreshControlAction(refreshControl: UIRefreshControl) {
        let apiKey = "8ce9303e71876a01e36c881453457030"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        //Before we make the network request, display the Progress HUD on View Controller
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                    data, options:[]) as? NSDictionary {
                    print("response: \(responseDictionary)")
                    
                    //Once the network request has been made, close the Progress HUD
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    //Now do the remainder of the response handling code liek saving the data to a global varable of movies (array of NSDictionary)
                    
                    //copy the responseDictionary saved in NSDictionary to a global/instance variable so we can access it in other places
                    //the array of movie data dictionaries is called results which is within responseDictionary
                    //save it as a NSDictionary array
                    //explicitly say that we are talking about my self movies
                    self.movies = responseDictionary["results"] as! [NSDictionary]
                    
                    
                    //tell it to reload the data after the new data has been pulled after the network request
                    self.tableView.reloadData()
                    
                    // Tell the refreshControl to stop spinning
                    refreshControl.endRefreshing()
                    
                    
                }
            }
        })
        task.resume()
    }
    
    
    
    
    
    //this is the network request method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        //something (refreshControlAction( :))will happen when you pull-to-refresh
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)

        tableView.dataSource = self //initialize the data source and delegate to be myselftbjuhllgddcnducilnbidlhhlvnrthgn
        tableView.delegate = self
        
        //Makes network request, updates tableview with new data (the movies array of NSDictionary), hides the Refresh Control
        refreshControlAction(refreshControl)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this dictates the number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //same number of rows as the number of movies in the movies array
        //if the array is NILL or network error, 
        if let movies = movies {
            //movies is not NULL
            return movies.count
        } else {
            //movies is NILL
            return 0
        }
    }
    
    //this describes how to go in and modify a particular row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // we called the TableViewCell with reuse identifier to be MovieCell
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let row = indexPath.row
        
        // this is a particular NSDictionary, the ! tells the computer that I know this value is not NILL
        let movie = movies![indexPath.row]
        //index into the NS Dictionary movie to get the title
        
        //this is how to access a key within the dictionary, cast as a String
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let posterpath = movie["poster_path"] as! String
        let imageURL = NSURL(string: baseURL + posterpath) //this is a string
        
        
        //cast above cell to MovieCell so you can say set title to something and set overview to something
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        // set Image using cocoa pods
        cell.posterView.setImageWithURL(imageURL!) //this method from setImage is from the cocoapod AFNetworking
        
        print(row) //print the current row number on screen
        // Note: Notice that the rows printed are the ones that are visible on the screen. Imagine if thousands of cells. USe reausable cells.. only deal with the cells on the screen. When one row/cell leaves the screen, its data is replaced with that of another
        return cell
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
