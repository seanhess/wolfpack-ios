//
//  MockData.swift
//  Wolf Pack
//
//  Created by Sean Hess on 9/4/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import Foundation

typealias ID = String

class Person {
    var id:ID = ""
    var firstName:String = ""
    var lastName:String = ""
    init(firstName:String, lastName:String) {
        self.id = mockRandomId()
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        get {
            return firstName + " " + lastName
        }
    }
}

class User : Person {
    var phone:String = ""
    init(firstName:String, lastName:String, phone:String) {
        self.phone = phone
        super.init(firstName: firstName, lastName: lastName)
    }
}

class Child : Person {
    var parentId:ID = ""
    init(firstName:String, lastName:String, parentId:ID) {
        self.parentId = parentId
        super.init(firstName:firstName, lastName:lastName)
    }
}

class PlayDate {
    var id:ID = ""
    var parent:User // the one who invited everybody
    init(parent:User) {
        self.id = mockRandomId()
        self.parent = parent
    }
}

func mockRandomId() -> String {
    return String(arc4random())
}



class MockData {
    
    var sean = User(firstName:"Sean",  lastName:"Hess", phone:"")
    var sarah = User(firstName:"Sarah", lastName:"Jones", phone:"")
    
    var users:[User] = []
    var kids:[Child] = []
    var dates:[PlayDate] = []
    
    init() {
        
        self.users = [sean, sarah]
        
        self.kids = [
            Child(firstName: "Peter", lastName: "Hess", parentId: sean.id),
            Child(firstName: "Jackson", lastName: "Hess", parentId: sean.id),
            Child(firstName: "Elora", lastName: "Hess", parentId: sean.id),
        
            Child(firstName: "Walter", lastName: "Jones", parentId: sarah.id),
            Child(firstName: "Augustina", lastName: "Jones", parentId: sarah.id),
        ]
        
        self.dates = [
            PlayDate(parent:sean)
        ]
    }
}

var mockData = MockData()
