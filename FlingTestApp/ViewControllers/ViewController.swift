//
//  ViewController.swift
//  FlingTestApp
//
//  Created by Jahanvi Vyas on 10/04/2016.
//  Copyright © 2016 Jahanvi Vyas. All rights reserved.
//

let kFeedCellIdentifier = "FeedTableViewCellIdentifier"

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var loadingIndicator: UIActivityIndicatorView!
    
    var feeds : NSMutableArray = [ ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.tableView.registerClass(FeedTableViewCell.self, forCellReuseIdentifier: kFeedCellIdentifier)
        
        //Get feed data
        self.showLoading()
        FeedDataManager.sharedInstance.getFeedDataWithCompletion {(error) -> Void in
            
            dispatch_async(dispatch_get_main_queue())
            {
                if((error) == nil)
                {
                    self.feeds = FeedDataManager.sharedInstance.feeds
                    self.tableView.reloadData()
                }
                else
                {
                    if(error?.code == kNoInternetErrorCode)
                    {
                        self.showErrorMessage("No Internet Connection")
                    }
                    else
                    {
                        self.showErrorMessage("Problem in server to load data")
                    }
                }
                self.hideLoading()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showErrorMessage(message:String) {
        let alertView = UIAlertController(title: "", message: message, preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
    }
    
    func showLoading() {
        
        if(loadingIndicator == nil)
        {
            loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
            loadingIndicator.center = view.center
            loadingIndicator.hidesWhenStopped = true
            view.addSubview(loadingIndicator)
        }
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        
        loadingIndicator.stopAnimating()
    }

    // MARK: - UITableViewDataSource Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120.0;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kFeedCellIdentifier, forIndexPath: indexPath) as! FeedTableViewCell
        
        let feed = feeds[indexPath.row] as! Feed
        cell.photoLabel.text = feed.photoTitle
        
        if(feed.photoImage == nil)
        {
            //Load image from image ID
        }
        else
        {
            //cell.photoImageView.image = feed.photoImage
        }
        return cell
    }
}

