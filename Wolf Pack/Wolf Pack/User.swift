//
//  User.swift
//  Wolf Pack
//
//  Created by Matthew Berteaux on 9/4/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var phone: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var friends: NSSet

}
