//
//  UserExtension.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import CoreData

extension User {

    convenience init(phone: String, firstName: String, lastName: String) {
        var entityDesc = NSEntityDescription.entityForName("User", inManagedObjectContext: ModelUtil.defaultMOC);
        self.init(entity: entityDesc, insertIntoManagedObjectContext: ModelUtil.defaultMOC)
//        self.phone = phone
//        self.firstName = firstName
//        self.lastName = lastName
//        self.friends = NSSet()
    }

    
    
    func save() -> Bool {
        return ModelUtil.commitDefaultMOC()
    }
}