//
//  KidsHomeViewController.swift
//  Wolf Pack
//
//  Created by Sean Hess on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import UIKit

class KidsHomeViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var userBackgroundImageView:UIImageView!
    @IBOutlet var userHeadImageView:UIImageView!
    @IBOutlet var userLabel:UILabel!
    
    let child = MOChild.create("henry", firstName: "asdf", lastName: "asdf")
    var me:MOUser!
    var testHead:KidHeadView?
    
    @IBOutlet var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        me = MOUser.me()
        
        // BLURRRRY
        var blurEffect = UIBlurEffect(style: .Light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = userBackgroundImageView.bounds
        blurEffectView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        userBackgroundImageView.addSubview(blurEffectView)
        userBackgroundImageView.sd_setImageWithURL(me.imageUrl())
        
        userHeadImageView.sd_setImageWithURL(me.imageUrl())
        
        userLabel.text = me.fullName()
        
        // Hide navigation bar
        self.navigationController?.navigationBarHidden = true
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if (indexPath.row == 4) {
            var cell:UICollectionViewCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("AddKidCell", forIndexPath: indexPath) as UICollectionViewCell
            return cell
        }
        else {
            var cell:UICollectionViewCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("KidCollectionViewCell", forIndexPath: indexPath) as UICollectionViewCell
            var headView = cell.contentView.subviews[0] as KidHeadView
            headView.updateChild(child)
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4+1 // for the button
    }
}
