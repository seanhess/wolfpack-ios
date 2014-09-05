//
//  MOPlayDateExtension.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import CoreData

extension MOPlayDate {
    class func create(date: NSDate, location: String, owner: MOUser) -> MOPlayDate {
        var playDate = NSEntityDescription.insertNewObjectForEntityForName("PlayDate", inManagedObjectContext: ModelUtil.defaultMOC) as MOPlayDate
        playDate.date = date
        playDate.location = location
        playDate.owner = owner

        return playDate
    }
}
