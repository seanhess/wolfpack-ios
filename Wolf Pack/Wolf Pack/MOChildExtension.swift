//
//  MOChildExtension.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import CoreData

extension MOChild {
    class func create(id: String, firstName: String, lastName: String, parents: MOUser...) -> MOChild {
        var child = NSEntityDescription.insertNewObjectForEntityForName("Child", inManagedObjectContext: ModelUtil.defaultMOC) as MOChild
        
        child.id = id
        child.firstName = firstName
        child.lastName = lastName
        child.parents = NSSet(array: parents)

        return child
    }

    func save() -> Bool {
        return ModelUtil.commitDefaultMOC()
    }
}
