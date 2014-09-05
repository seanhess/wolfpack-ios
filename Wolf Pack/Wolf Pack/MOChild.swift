//
//  MOChild.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import Foundation
import CoreData

class MOChild: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var id: String
    @NSManaged var lastName: String
    @NSManaged var invitations: NSSet
    @NSManaged var parent: Wolf_Pack.MOUser

}
