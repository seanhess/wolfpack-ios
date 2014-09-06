//
//  MOPlayDate.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import Foundation
import CoreData

class MOPlayDate: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var date: NSDate
    @NSManaged var location: String
    @NSManaged var owner: MOUser
    @NSManaged var invitations: NSSet

}
