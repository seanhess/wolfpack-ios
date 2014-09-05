//
//  UserExtension.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import CoreData

extension MOUser: FromJSON, Fetchable {

    class func create(id: String, phone: String, firstName: String, lastName: String) -> MOUser {
        var user = NSEntityDescription.insertNewObjectForEntityForName(MOUser.entityName(), inManagedObjectContext: ModelUtil.defaultMOC) as MOUser
        user.phone = phone
        user.firstName = firstName
        user.id = id
        user.lastName = lastName

        return user
    }
    
    class func fetchOrCreate(id: String) -> MOUser {
        var maybeUser = self.fetch(id)
        if let user = maybeUser {
            return user
        }
        else {
            // create a new one
            let user = MOUser.create(id, phone: "", firstName: "", lastName: "")
            return user
        }
    }
    
    class func fetch(id:String) -> MOUser? {
        return ModelUtil.fetch(NSPredicate(format: "id == %@", id))
    }
    
    // loads them into the data store
    class func loadUsers() {
        let url = NSURL(string: "http://wolfpack-api.herokuapp.com/users")
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, hasError) in

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
        self.firstName = json["firstName"].string!
    }
    
    
    
    func imageUrl() -> NSURL {
        return NSURL(string:"http://www.hess-dietz.de/resources/Frau+Hess.JPG")
    }
    
    class func me() -> MOUser {
        return self.fetchOrCreate("5409ef307f48400200582d9a")
    }
    
    func fullName() -> String {
        return firstName + " " + lastName
    }

    class func entityName () -> String {
        return "User"
    }
}