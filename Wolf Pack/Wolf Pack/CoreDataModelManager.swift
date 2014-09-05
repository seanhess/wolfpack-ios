//
//  CoreDataModelManager.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/4/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import CoreData

class CoreDataModelManager {
    class var sharedInstance: CoreDataModelManager{
        struct Singleton {
            static let instance = CoreDataModelManager()
        }
        return Singleton.instance
    }
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("Wolf_Pack", withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOfURL: modelURL)
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        if let persistentStoreCoordinator = self.persistentStoreCoordinator {
            var managedObjectContext = NSManagedObjectContext()
            
            managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
            
            return managedObjectContext
        }
        return nil
    }()
    
    lazy var applicationDocumentsDirectory: NSURL? = {
       return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last as? NSURL
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        if let url = self.storeURL {
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            
            let options = [
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true
            ]
            
            var error: NSError?
            
            let persistentStore = persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options, error: &error)
            if persistentStore == nil {
                println("Error adding persistent store: \(error)")
                fatalError("Could not add the persistent store.")
                return nil
            }
            return persistentStoreCoordinator
        }
        return nil
    }()
    
    lazy var storeURL: NSURL? = {
        if let add = self.applicationDocumentsDirectory {
            return add.URLByAppendingPathComponent("Wolf_Pack.sqlite")
        }
        return nil
    }()
}