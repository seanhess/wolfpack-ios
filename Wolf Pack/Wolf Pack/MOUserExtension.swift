//
//  UserExtension.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import CoreData

extension MOUser: FromJSON {

    class func create(id: String, phone: String, firstName: String, lastName: String) -> MOUser {
        var user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: ModelUtil.defaultMOC) as MOUser
        user.phone = phone
        user.firstName = firstName
        user.id = id
        user.lastName = lastName

        return user
    }
    
//    func save() -> Bool {
//        println("save \(self.firstName)")
//        return ModelUtil.commitDefaultMOC()
//    }
    
    class func fetchOrCreate(id: String) -> MOUser {
        var maybeUser = self.fetch(id)
        if let user = maybeUser {
            println("Found User \(id)")
            return user
        }
        else {
            // create a new one
            println("Created User \(id)")
            let user = MOUser.create(id, phone: "", firstName: "", lastName: "")
            return user
        }
    }
    
    class func fetch(id:String) -> MOUser? {
        var error:NSError?
        var predicate = NSPredicate(format: "id == %@", id)
        var request = NSFetchRequest()
        request.entity = NSEntityDescription.entityForName("User", inManagedObjectContext: ModelUtil.defaultMOC)
        request.predicate = predicate
        let maybeResults = ModelUtil.defaultMOC.executeFetchRequest(request, error:&error)
        
        if let results = maybeResults {
            if results.count > 0 {
                return (results[0] as MOUser)
            }
        }
        
        return nil
    }
    
    // loads them into the data store
    class func loadUsers() {
        let url = NSURL(string: "http://wolfpack-api.herokuapp.com/users")
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, hasError) in

            println("got USERS")
            if let error = hasError {
                println("Error: \(error)")
                return
            }

            let json = JSONValue(data)
            switch json {
                case .JArray(let jsonArray) where jsonArray.count > 0:
                    for (index, jsonUser) in enumerate(jsonArray) {
                        // here I have the json objects I need
                        let id = jsonUser["_id"].string!
                        
                        var user = self.fetchOrCreate(id)
                        user.updateFromJSON(jsonUser)
                    }
                
                    ModelUtil.commitDefaultMOC()
                
                default:
                    println("could not parse")
            }
        }
    }
    
    func updateFromJSON(json:JSONValue) {
        println("update user \(self.id)")
        self.firstName = json["firstName"].string!
    }
}