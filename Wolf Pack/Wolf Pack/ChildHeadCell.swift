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

class ChildHeadCell : UICollectionViewCell, InvitationStatusDelegate {
    
    var imageView:UIImageView!
    var checkView:UIImageView!
    var nameLabel:UILabel!
    
    var circle:CAShapeLayer!
    var drawAnimation:CABasicAnimation?
    var child:MOChild?

    var invitation:InvitationStatus?
    
    func configure() {
        self.backgroundColor = UIColor.clearColor()
        self.clipsToBounds = false
        
        checkView = UIImageView(image: UIImage(named: "check.png"))
        checkView.frame = CGRectMake(self.bounds.size.width-24, self.bounds.size.width-24, 26, 26)
        
        imageView = UIImageView(frame: self.bounds)
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.clearColor().CGColor
        imageView.layer.borderWidth = 3
        
        nameLabel = UILabel(frame: CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 20))
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(checkView)
        self.contentView.addSubview(nameLabel)
        
        circle = CAShapeLayer()
        imageView.layer.addSublayer(circle)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        configure()
    }

    // this RE-SETS the data, never animating
    func setData(child:MOChild, selected:Bool) {
        self.child = child
        let url = NSURL(string:child.imageUrl)
        imageView.sd_setImageWithURL(url)
        nameLabel.text = child.firstName
        renderSelected(selected)
    }
    
    // alternative to setData
    func setInvitationStatus(invite:InvitationStatus) {
        invitation?.delegate = nil
        invitation = invite
        invitation?.delegate = self
        setData(invite.child, selected:invite.invited)
    }
    
    // without animation
    func renderSelected(value:Bool) {
        circle.hidden = !value
        checkView.hidden = !value
    }
    
    func animateCircle() {
        let radius = imageView.bounds.size.width/2
        
        // Make a circular shape
        circle.path = UIBezierPath(roundedRect: CGRectMake(0, 0, 2.0*radius, 2.0*radius), cornerRadius: radius).CGPath
        // Center the shape in self.view
        circle.position = CGPointMake(CGRectGetMidX(self.imageView.frame)-radius,
        CGRectGetMidY(self.imageView.frame)-radius);
        
        // Configure the apperence of the circle
        circle.fillColor = UIColor.clearColor().CGColor
        circle.strokeColor = WPColorGreen.CGColor
        circle.lineWidth = 5
        circle.hidden = false
        
        // Configure animation
        drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation?.duration            = 0.5 // "animate over 10 seconds or so.."
        drawAnimation?.repeatCount         = 1.0  // Animate only once..

        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        drawAnimation?.fromValue = 0.0
        drawAnimation?.toValue   = 1.0

        // Experiment with timing to get the appearence to look the way you want
        drawAnimation?.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

        // Add the animation to the circle
        circle.addAnimation(drawAnimation, forKey:"drawCircleAnimation")

        delay(0.5) {
            println("done")
            self.checkView.hidden = false
            var frame = self.checkView.frame
            frame.size = CGSize(width: 0, height: 0)
            self.checkView.frame = frame
            
            UIView.animateWithDuration(0.2, animations: {
                frame.size = CGSize(width: 26, height: 26)
                self.checkView.frame = frame
            }, completion: {(done) in
                
            })
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        circle.removeAllAnimations()
//        println("prepare for reuse")
//    }
    
    func didUpdateStatus() {
        if self.invitation!.invited {
            circle.hidden = false
            animateCircle()
        }
        else {
            circle.hidden = true
            checkView.hidden = true
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
