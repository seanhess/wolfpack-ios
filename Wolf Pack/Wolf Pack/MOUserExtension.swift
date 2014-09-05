//
//  UserExtension.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import CoreData

extension MOUser {

    class func create(id: String, phone: String, firstName: String, lastName: String) -> MOUser {
        var user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: ModelUtil.defaultMOC) as MOUser
        user.phone = phone
        user.firstName = firstName
        user.id = id
        user.lastName = lastName

        return user
    }
    
    func save() -> Bool {
        return ModelUtil.commitDefaultMOC()
    }
}