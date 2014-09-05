//
//  Fetchable.swift
//  Wolf Pack
//
//  Created by Matt Berteaux on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import Foundation

protocol Fetchable {
    var id:String {get set}
    class func entityName() -> String
}