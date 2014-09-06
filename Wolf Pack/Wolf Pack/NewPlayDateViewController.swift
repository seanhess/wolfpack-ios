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
    
    var invitations:[InvitationStatus] = []
    var myKids:[MOChild] = []
    
    var me:MOUser!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        me = MOUser.me()
        
        if let child = myKids.first {
            myKidsImageView.sd_setImageWithURL(NSURL(string:child.imageUrl))
        }
        
        var request = MOChild.otherChildrenRequest(me.id)
        let result = ModelUtil.execute(request) as [MOChild]
        invitations = result.map({(child) in InvitationStatus(child: child, invited:false, accepted:false)})
        collectionView.reloadData()
    }
    
    /// TABLE VIEW
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:ChildHeadCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("ChildHeadCell", forIndexPath: indexPath) as ChildHeadCell
        var status = invitations[indexPath.row]
        cell.setData(status.child, selected:status.invited)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return invitations.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var status = invitations[indexPath.row]
        status.invited = !status.invited
        collectionView.reloadData()
    }

    @IBAction func sendInvite(sender: AnyObject) {
        var playDate = MOPlayDate.create(NSDate(), location:"", owner: me)

        var otherInvitations = invitations.filter({ (status) in
            return status.invited
        }).map({(status) in
            return MOInvitation.create(status.child, status: MOInvitationStatusInvited, playDate: playDate)
        }) as [MOInvitation]
        
        var kidInvitations = myKids.map({ (child) in
            return MOInvitation.create(child, status: MOInvitationStatusAccepted, playDate: playDate)
        }) as [MOInvitation]
        
        var allInvitations = otherInvitations + kidInvitations
        
        // now POST it. wheeeee
    }
    
}