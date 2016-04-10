//
//  RestAPIManager.swift
//  FlingTestApp
//
//  Created by Jahanvi Vyas on 10/04/2016.
//  Copyright © 2016 Jahanvi Vyas. All rights reserved.
//

import Foundation

class RestAPIManager: NSObject {
    
    class func requestDataWithURL(url: NSURL, completionHandler:((NSData?,NSError?)) -> Void)
    {
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                //Successful
                //let urlContent = NSString(data: data!, encoding: NSASCIIStringEncoding) as NSString!
                //print(urlContent)
            }
            completionHandler(data,error)
        })
        task.resume()
    }
    
    class func downloadRequestWithURL(url: NSURL, completionHandler:((NSData?,NSError?)) -> Void)
    {
        //let url:NSURL = NSURL(string: kBaseURL)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        //let paramString = "data=Hello"
        //request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = session.downloadTaskWithRequest(request) {
            (
            let location, let response, let error) in
            
            guard let _:NSURL = location, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
            let urlContents = try! NSString(contentsOfURL: location!, encoding: NSUTF8StringEncoding)
            
            guard let _:NSString = urlContents else {
                print("error")
                return
            }
            
            print(urlContents)
            
        }
        
        task.resume()
        
    }
    
    class func isConnectedToNetwork() -> Bool {
        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != 0
    }
    
}