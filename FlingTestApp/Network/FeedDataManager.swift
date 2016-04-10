//
//  FeedDataManager.swift
//  FlingTestApp
//
//  Created by Jahanvi Vyas on 10/04/2016.
//  Copyright © 2016 Jahanvi Vyas. All rights reserved.
//

import Foundation

class FeedDataManager: NSObject {
    
    static let sharedInstance = FeedDataManager()
    
    var feeds: NSMutableArray = []
    
    func getFeedDataWithCompletion(completionHandler:((NSError?)) -> Void)
    {
            if(RestAPIManager.isConnectedToNetwork())
            {
                let url:NSURL = NSURL(string: kBaseURL)!
                RestAPIManager.requestDataWithURL(url,completionHandler: { (data, error) -> Void in
                    if error == nil {
                        self.parseJSONData(data!)
                        completionHandler(error)
                    }
                    else
                    {
                        completionHandler(error)
                    }
                })
            }
            else
            {
                completionHandler(NSError(domain: "", code: kNoInternetErrorCode, userInfo: nil))
            }
        
    }
    
    
    
    func parseJSONData(data:NSData)
    {
        let coreDataManagerClear = CoreDataManager()
        coreDataManagerClear.clearFeedData()
        var feedsArray: NSArray!
        do {
            feedsArray = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSArray
            
            for feed in feedsArray {
                let coreDataManager = CoreDataManager()
                let feed: Feed = coreDataManager.saveFeed(feed as! NSDictionary)
                self.feeds.addObject(feed)
            }
            
        } catch {
            print(error)
        }
        
        /*let gameResponse = GameResponse()
        gameResponse.initWithProperties(json)
        self.currency = gameResponse.currency
        self.games = gameResponse.games*/
    }

}