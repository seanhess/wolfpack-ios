//
//  MOChildExtension.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import CoreData

extension MOChild: Fetchable, FromJSON {
    class func create(id: String, firstName: String?, lastName: String?) -> MOChild {
        var child = NSEntityDescription.insertNewObjectForEntityForName("Child", inManagedObjectContext: ModelUtil.defaultMOC) as MOChild
        
        child.id = id
        if (firstName != nil) {child.firstName = firstName!}
        if (lastName != nil) {child.lastName = lastName!}
        child.imageUrl = "http://playingwithsuperpower.com/wp-content/uploads/2014/05/Tick-pic.jpg"

        return child
    }

    class func fetchOrCreate(id: String) -> MOChild {
        var maybeChild = self.fetch(id)
        if let child = maybeChild {
            return child
        }
        else {
            // create a new one
            let child = MOChild.create(id, firstName: nil, lastName: nil)
            return child
        }
    }

    class func fetch(id:String) -> MOChild? {
        return ModelUtil.fetch(NSPredicate(format: "id == %@", id))
    }

    class func syncREST() {
        let url = NSURL(string: "http://wolfpack-api.herokuapp.com/children")
        loadRESTObjects(url) { json in
            // here I have the json objects I need
            let id = json["_id"].string!
            var child = self.fetchOrCreate(id)
            child.updateFromJSON(json)
        }
    }

    class func entityName () -> String {
        return "Child"
    }

    func updateFromJSON(json:JSONValue) {
        self.firstName = json["firstName"].string!
        self.lastName = json["lastName"].string!

        var parentID = json["parentId"].string!
        var parent = MOUser.fetchOrCreate(parentID)
        
        if let value = json["imageUrl"].string {
            println("Hello", value)
            self.imageUrl = value
        }
        
        self.parent = parent
        println("Child \(self.firstName) to Parent \(self.parent.firstName) \(self.parent.id)")
    }
    
    class func childrenRequest(parentId:String) -> NSFetchRequest {
        var request = self.allChildren()
        request.predicate = NSPredicate(format: "parent.id == %@", parentId)
        return request
    }
    
    class func allChildren() -> NSFetchRequest {
        var request = NSFetchRequest(entityName: self.entityName())
        var sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        return request
    }
    
}
