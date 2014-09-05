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
}
