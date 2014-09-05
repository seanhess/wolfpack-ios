//
//  FromJSON.swift
//  Wolf Pack
//
//  Created by Sean Hess on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import Foundation

protocol FromJSON {
    func updateFromJSON(jsonData:JSONValue)
}