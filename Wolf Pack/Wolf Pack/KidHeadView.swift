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

// 100x100

class KidHeadView : UIView {

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        backgroundColor = UIColor.clearColor()
    }
    
    // lazy image view
    lazy var imageView:UIImageView = {
        let view = UIImageView()
        view.frame = self.bounds
//        view.backgroundColor = UIColor.orangeColor()
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
        imageView.backgroundColor = UIColor.redColor()
//        self.backgroundColor = UIColor.blueColor()
        let url = NSURL(string:"https://lh3.googleusercontent.com/-vpRiaN7tRHg/AAAAAAAAAAI/AAAAAAAAAAA/LiDbyWt1mUw/s128-c-k/photo.jpg")
        imageView.sd_setImageWithURL(url)
        
        // this blur is significant
//        var blurEffect = UIBlurEffect(style: .Light)
//        var vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
//        var vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
//        vibrancyEffectView.frame = imageView.bounds
//        var blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = imageView.bounds
//        
//        imageView.addSubview(blurEffectView)
    }
    
    var isSelected:Bool = false {
        didSet {
            println("Set Selected \(isSelected)")
        }
    }
    
    func addHoverEffect() {
        // make it a little bigger
        // make it pop off the page
        // add a drop shadow
        
        println("Add hover effect")
        

        
        UIView.animateWithDuration(0.5) {
            var frame = self.imageView.frame
            frame.origin.x = 4
            frame.origin.y = 4
            frame.size.width = self.bounds.size.width + 10
            frame.size.height = self.bounds.size.height + 10
            self.imageView.frame = frame
        }
        
        self.imageView.layer.cornerRadius = (self.bounds.size.height+10) / 2
        
        self.imageView.layer.shadowColor = UIColor.blackColor().CGColor
        self.imageView.layer.shadowOpacity = 0.7
        self.imageView.layer.shadowOffset = CGSizeMake(-4, -4)
        self.imageView.layer.shadowRadius = 0.5
        self.imageView.layer.masksToBounds = false
    }
}
