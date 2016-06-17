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


class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    var movies: [NSDictionary]?
    var filteredMovies: [NSDictionary]?
    
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
                    self.filteredMovies = self.movies
                    
                    
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
        let logoURLString = "http://cdn.iconmonstr.com/wp-content/assets/preview/2012/240/iconmonstr-video-8.png"
        //let logoURLString = "file:///Users/nidhimanoj/Downloads/iconmonstr-video-8.svg"
        let logoURL = NSURL(string: logoURLString)
        logoImageView.setImageWithURL(logoURL!) //setImage is from the cocoapod AFNetworking
        
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        //something (refreshControlAction( :))will happen when you pull-to-refresh
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        //initialize the data source and delegate to be myself
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self as? UISearchBarDelegate
        filteredMovies = movies
        
        //Makes network request, updates tableview with new data (the movies array of NSDictionary), hides the Refresh Control
        
        refreshControlAction(refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this dictates the number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //same number of rows as the number of movies in the movies array
        //if the array is NILL or network error,
        if let filteredMovies = filteredMovies {
            //movies is not NULL
            return filteredMovies.count
        } else {
            //movies is NILL
            return 0
        }
    }
    
    //this describes how to go in and modify a particular row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // we called the TableViewCell with reuse identifier to be MovieCell
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        // this is a particular NSDictionary, the ! tells the computer that I know this value is not NILL, index into the NS Dictionary movie to get the title
        let movie = filteredMovies![indexPath.row]
        
        //this is how to access a key within the dictionary, cast as a String
        let title = movie["title"] as? String
        cell.titleLabel.text = title
        let overview = movie["overview"] as? String
        cell.overviewLabel.text = overview
        cell.overviewLabel.sizeToFit()
        let rating = movie["release_date"] as? String
        cell.ratingLabel.text = rating
        
        let baseURL = "http://image.tmdb.org/t/p/w500"
        if let posterpath = movie["poster_path"] as? String { //poster_path is not NILL
            let imageURL = NSURL(string: baseURL + posterpath)
            /* Immediately show image
            cell.posterView.setImageWithURL(imageURL!) //this method from setImage is from the cocoapod AFNetworking
            */
            
            // Fade the image in
            let imageRequest = NSURLRequest(URL: imageURL!)
            cell.posterView.setImageWithURLRequest(imageRequest, placeholderImage: nil, success: { (imageRequest, imageResponse, image) -> Void in
                
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    print("Image was NOT cached, fade in image")
                    cell.posterView.alpha = 0.0
                    cell.posterView.image = image
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        cell.posterView.alpha = 1.0
                    })
                } else {
                    print("Image was cached so just update the image")
                    cell.posterView.image = image
                }
                },
                failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
            })
            
            
            
            
            
            
            
            
            
            
        }
        // Note: Notice that the rows printed are the ones that are visible on the screen. Imagine if thousands of cells. USe reausable cells.. only deal with the cells on the screen. When one row/cell leaves the screen, its data is replaced with that of another
        return cell
    }
    
    
    //SEARCH BAR FILTERING
    // This method updates filteredData based on the text in the Search Box
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            // For each item, return true if the item should be included and false if the
            // item should NOT be included
            filteredMovies = movies!.filter({(movieItem: NSDictionary) -> Bool in
                let title = movieItem["title"] as! String
                // If title matches the searchText, return true to include it
                if title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        tableView.reloadData()
    }
    
    
    
    
    //PUSH TO A DETAIL PAGE
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //The sender is the MovieCell
        let cell = sender as! UITableViewCell
        //Use the indexPathForCell to get the index for a cell, use that index to access the movie in movies array from data
        let indexPath = tableView.indexPathForCell(cell)
        let movie = filteredMovies![indexPath!.row] // get the right movie
        
        //Segue is where we are going to which is an instance of DetailViewController, set its movie variable to be this movie of the cell. The detailedViewController will use this movie to get data and image
        let detailedViewController = segue.destinationViewController as! DetailViewController
        detailedViewController.movie = movie
        
    }
    
    
    
}
