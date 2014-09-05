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
        self.parent = parent
    }
}
