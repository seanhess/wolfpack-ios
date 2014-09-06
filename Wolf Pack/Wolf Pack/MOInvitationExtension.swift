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

extension MOInvitation: ToJSON {
    
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

    func send() {
        println("sending invite \(self.toJSON())")

        var url = NSURL(string: "http://wolfpack-api.herokuapp.com/invitations")
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = self.toJSON().description.dataUsingEncoding(NSUTF8StringEncoding)

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, hasError) in
            println(response)
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
//            let json = JSONValue(data)
//            var id = json["_id"].string!
//            self.id = id
//            ModelUtil.commitDefaultMOC()
        }
    }

    func toJSON() -> JSONValue {
        var dict = NSMutableDictionary()

        dict.setValue(self.playDate.id, forKey: "playDateId")
        dict.setValue(self.child.id, forKey: "childId")
        dict.setValue(self.confirmationStatus, forKey: "confirmed")

        return JSONValue(dict)
    }
}
