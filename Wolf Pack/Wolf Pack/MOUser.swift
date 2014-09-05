//
//  MOUser.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import Foundation
import CoreData

class MOUser: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var phone: String
    @NSManaged var id: String
    @NSManaged var friends: NSSet
    @NSManaged var playDates: NSSet

}
