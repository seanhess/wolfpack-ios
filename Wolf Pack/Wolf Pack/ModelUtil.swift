//
//  ModelUtil.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import CoreData

class ModelUtil {
    
    class var defaultMOC: NSManagedObjectContext {
        return CoreDataModelManager.sharedInstance.managedObjectContext!
    }
    
    class func execute(request:NSFetchRequest) -> [AnyObject] {
        var error:NSError?
        var maybeResult = ModelUtil.defaultMOC.executeFetchRequest(request, error: &error)
        if let result = maybeResult {
            return result
        }
        return []
    }
    
    class func commitDefaultMOC() -> Bool {
        let moc = ModelUtil.defaultMOC
        var error: NSError?
        
        if !moc.save(&error) {
            println("Failed to save default MOC")
            return false
        }
        return true
    }
    
    class func deleteManagedObjectFromDefaultMOC(managedObject: NSManagedObject) {
        let moc = ModelUtil.defaultMOC
        moc.deleteObject(managedObject)
    }
    
    class func fetch<T: Fetchable>(predicate: NSPredicate) -> T? {
        var error:NSError?
        var request = NSFetchRequest()
        request.entity = NSEntityDescription.entityForName(T.entityName(), inManagedObjectContext: ModelUtil.defaultMOC)
        request.predicate = predicate
        let maybeResults = ModelUtil.defaultMOC.executeFetchRequest(request, error:&error)

        if let results = maybeResults {
            if results.count > 0 {
                return (results[0] as T)
            }
        }
        
        return nil
    }
}

// loads them into the data store
func loadRESTObjects(url:NSURL, process:(JSONValue) -> Void) {
    let request = NSURLRequest(URL: url)
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, hasError) in
        
        if let error = hasError {
            println("Error: \(error)")
            return
        }
        
        let json = JSONValue(data)
        switch json {
        case .JArray(let jsonArray) where jsonArray.count > 0:
            for (index, jsonValue) in enumerate(jsonArray) {
                process(jsonValue)
            }
            
            ModelUtil.commitDefaultMOC()
            
        default:
            println("could not parse")
        }
    }
}