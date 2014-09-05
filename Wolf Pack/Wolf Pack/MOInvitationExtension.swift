//
//  MOInvitationExtension.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import CoreData

extension MOInvitation {
    
    class func create(child: MOChild, status: String, playDate: MOPlayDate) -> MOInvitation {
        var invite = NSEntityDescription.insertNewObjectForEntityForName("Invitation", inManagedObjectContext: ModelUtil.defaultMOC) as MOInvitation

        invite.confirmationStatus = status
        invite.child = child
        invite.playDate = playDate

        return invite
    }

    func save() -> Bool {
        return ModelUtil.commitDefaultMOC()
    }
}
