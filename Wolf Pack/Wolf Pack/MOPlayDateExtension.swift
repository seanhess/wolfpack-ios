//
//  MOPlayDateExtension.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//




import CoreData

extension MOPlayDate: ToJSON {
    class func create(date: NSDate, location: String, owner: MOUser) -> MOPlayDate {
        var playDate = NSEntityDescription.insertNewObjectForEntityForName("PlayDate", inManagedObjectContext: ModelUtil.defaultMOC) as MOPlayDate
        playDate.date = date
        playDate.location = location
        playDate.owner = owner

        return playDate
    }
    
    func addInvitationChild(child:MOChild) -> MOInvitation {
        return MOInvitation.create(child, status: MOInvitationStatusInvited, playDate: self)
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
    
    class func requestAll() -> NSFetchRequest {
        var request = NSFetchRequest(entityName: "PlayDate")
        var sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        return request
    }
    
    class func send(playDate:MOPlayDate, invitations:[MOInvitation]) {
        var url = NSURL(string: "http://wolfpack-api.herokuapp.com/playdates")
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = playDate.toJSON().description.dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, hasError) in
            let json = JSONValue(data)
            var id = json["_id"].string!
            playDate.id = id
            ModelUtil.commitDefaultMOC()

            for invite in invitations {
                invite.playDate = playDate
                invite.send()
            }
        }
    }

    func toJSON() -> JSONValue {
        let dateFormatter = NSDateFormatter(); dateFormatter.dateFormat = "MM/dd/yyyy";
        let dateStr = dateFormatter.stringFromDate(self.date)
        var dict = NSMutableDictionary()
        dict.setValue(dateStr, forKey: "date")
        dict.setValue(self.owner.id, forKey: "ownerId")
        var arr = NSArray(object: self.location)
        dict.setValue(arr, forKey: "location")
        return JSONValue(dict)
    }
}
