//
//  KidHeadView.swift
//  Wolf Pack
//
//  Created by Sean Hess on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import UIKit

// this has a circle head, and a label name underneath it. 
// should I make an interface builder thing?
// make just the head for now.

class KidHeadView : UIView {
    
    // lazy image view
    lazy var imageView:UIImageView = {
        let view = UIImageView()
        view.frame = self.bounds
        view.backgroundColor = UIColor.orangeColor()
        self.addSubview(view)
        println("hello bobby")
        return view
    }()

    var child:MOChild?
    
    func updateChild(child:MOChild) {
        self.child = child
//        layer.cornerRadius = 50.0
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.layer.masksToBounds = true
        let url = NSURL(string:"https://lh3.googleusercontent.com/-vpRiaN7tRHg/AAAAAAAAAAI/AAAAAAAAAAA/LiDbyWt1mUw/s128-c-k/photo.jpg")
        imageView.sd_setImageWithURL(url)
    }
    
}
