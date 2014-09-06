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
    
    func addInvitationChild(child:MOChild) -> MOInvitation {
        if let invitation = self.findInvitation(child) {
            return invitation
        }
        else {
            return MOInvitation.create(child, status: "", playDate: self)
        }
    }
    
    func findInvitation(child:MOChild) -> MOInvitation? {
        for element in self.invitations {
            if let invitation = element as? MOInvitation {
                if invitation.child.id == child.id {
                    return invitation
                }
            }
        }
        return nil
    }
    
}
