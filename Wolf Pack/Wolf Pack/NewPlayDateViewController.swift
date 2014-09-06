//
//  NewPlayDateViewController.swift
//  Wolf Pack
//
//  Created by Sean Hess on 9/6/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import Foundation

class NewPlayDateViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var myKidsImageView:UIImageView!
    @IBOutlet var collectionView:UICollectionView!
    
    var children:[MOChild] = []
    var invitations:[InvitationStatus] = []
    var myKids:[MOChild] = []
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load children
        // create an array of invitations for them
        
        
        if let child = myKids.first {
            myKidsImageView.sd_setImageWithURL(NSURL(string:child.imageUrl))
        }

    }
    
    /// TABLE VIEW
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:ChildHeadCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("ChildHeadCell", forIndexPath: indexPath) as ChildHeadCell
//        var maybeChild = self.fetchedResults?.objectAtIndexPath(indexPath) as MOChild?
//        if let child = maybeChild {
//            cell.setData(child, selected:isSelected(child))
//        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    
}