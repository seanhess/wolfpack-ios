//
//  MOInvitationExtension.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import CoreData


let MOInvitationStatusInvited = "Invited"
let MOInvitationStatusAccepted = "Accepted"
let MOInvitationStatusArrived = "Arrived"
let MOInvitationStatusDeclined = "Declined"

extension MOInvitation {
    
    class func create(child: MOChild, status: String, playDate: MOPlayDate) -> MOInvitation {
        var invite = NSEntityDescription.insertNewObjectForEntityForName("Invitation", inManagedObjectContext: ModelUtil.defaultMOC) as MOInvitation

        invite.confirmationStatus = status
        invite.child = child
        invite.playDate = playDate

        return invite
    }
    
    class func requestAll() -> NSFetchRequest {
        var request = NSFetchRequest(entityName: "Invitation")
        var sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        return request
    }
    
    class func requestPlayDate(playDateId:String) -> NSFetchRequest {
        var request = self.requestAll()
        request.predicate = NSPredicate(format: "playDate.id == %@", playDateId)
        return request
    }
}
