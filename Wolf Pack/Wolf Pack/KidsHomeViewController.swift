//
//  KidsHomeViewController.swift
//  Wolf Pack
//
//  Created by Sean Hess on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import UIKit

class KidsHomeViewController : UIViewController {
    override func viewDidLoad() {
        let child = MOChild.create("henry", firstName: "asdf", lastName: "asdf", parents: nil)
        
        var testHead:KidHeadView = KidHeadView()
        testHead.frame = CGRectMake(0, 200, 100, 100)
        testHead.updateChild(child)
        
        view.addSubview(testHead)
    }
}
