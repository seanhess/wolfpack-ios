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

class ChildHeadCell : UICollectionViewCell {
    
    var imageView:UIImageView!
    var child:MOChild?

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.backgroundColor = UIColor.clearColor()

        imageView = UIImageView(frame: self.bounds)
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.clearColor().CGColor
        imageView.layer.borderWidth = 3
        
        self.contentView.addSubview(imageView)
    }

    func setData(child:MOChild, selected:Bool) {
        self.child = child
        let url = NSURL(string:child.imageUrl)
        imageView.sd_setImageWithURL(url)
        renderSelected(selected)
    }
    
    func renderSelected(value:Bool) {
        if value {
            imageView.layer.borderColor = UIColor(red: 0.14, green: 0.72, blue: 0.32, alpha: 1.0).CGColor
        }
        else {
            imageView.layer.borderColor = UIColor.clearColor().CGColor
        }
    }
    
    
    
    
    
    
    
//    func addHoverEffect() {
//        // make it a little bigger
//        // make it pop off the page
//        // add a drop shadow
//        
//
//        
//        UIView.animateWithDuration(0.5) {
//            var frame = self.imageView.frame
//            frame.origin.x = 4
//            frame.origin.y = 4
//            frame.size.width = self.bounds.size.width + 10
//            frame.size.height = self.bounds.size.height + 10
//            self.imageView.frame = frame
//        }
//        
//        self.imageView.layer.cornerRadius = (self.bounds.size.height+10) / 2
//        
//        self.imageView.layer.shadowColor = UIColor.blackColor().CGColor
//        self.imageView.layer.shadowOpacity = 0.7
//        self.imageView.layer.shadowOffset = CGSizeMake(-4, -4)
//        self.imageView.layer.shadowRadius = 0.5
//        self.imageView.layer.masksToBounds = false
//    }
}
