//
//  CoreDataManager.swift
//  FlingTestApp
//
//  Created by Jahanvi Vyas on 10/04/2016.
//  Copyright © 2016 Jahanvi Vyas. All rights reserved.
//

import UIKit
import CoreData

struct feedDictionaryKeys {
    
    var feedID = "ID"
    var userID = "UserID"
    var photoTitle = "Title"
    var userName = "UserName"
    var photoID = "ImageID"
}

class CoreDataManager: NSObject {
    
    let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    func saveFeed(feedData:NSDictionary) -> Feed {
        
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Feed",
                                                        inManagedObjectContext:managedContext)
        
        //let photoEntity =  NSEntityDescription.entityForName("Photo",
                                                    //inManagedObjectContext:managedContext)
        
        
        let feed = Feed(entity: entity!,
                            insertIntoManagedObjectContext: managedContext)
        
        //let photo = Photo(entity: photoEntity!,
        //                insertIntoManagedObjectContext: managedContext)
        
        
        feed.feedID = feedData["ID"] as? NSNumber
        feed.userID = feedData["UserID"] as? NSNumber
        feed.photoTitle = feedData["Title"] as? String
        feed.userName = feedData["UserName"] as? String
        feed.photoID = feedData["ImageID"] as? NSNumber
        //feed.photo = photo
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        return feed
    }
    
    func clearFeedData() {
        let managedContext = appDelegate.managedObjectContext
        let persistentStoreCoordinator = appDelegate.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Feed")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentStoreCoordinator.executeRequest(deleteRequest, withContext: managedContext)
        } catch let error as NSError {
            debugPrint(error)
        }
    }

}