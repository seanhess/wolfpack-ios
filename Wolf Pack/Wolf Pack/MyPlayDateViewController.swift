//
//  MyPlayDateViewController.swift
//  Wolf Pack
//
//  Created by George Shank on 9/6/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import UIKit
import CoreData

class MyPlayDateViewController: UIViewController {
    
    @IBOutlet var userBackgroundImageView:UIImageView!
    @IBOutlet var userHeadImageView:UIImageView!
    @IBOutlet var userLabel:UILabel!
    @IBOutlet var collectionView:UICollectionView!
    
    var playDate:MOPlayDate!
    var invitations:[MOInvitation] = []
    var me:MOUser!
    
    var isOwner:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        me = MOUser.me()
        isOwner = me == playDate.owner
        userBackgroundImageView.sd_setImageWithURL(NSURL(string:me.imageUrl))
        userHeadImageView.sd_setImageWithURL(NSURL(string:me.imageUrl))
        userLabel.text = me.firstName
        
        invitations = playDate.invitations.allObjects as [MOInvitation]
        collectionView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func close() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func delete() {
        ModelUtil.defaultMOC.deleteObject(playDate)
        self.close()
    }

    
    
    // COLLECTION VIEW
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:ChildHeadCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("ChildHeadCell", forIndexPath: indexPath) as ChildHeadCell
        var invitation = invitations[indexPath.row]
        cell.setData(invitation.child, selected:(invitation.confirmationStatus == MOInvitationStatusArrived))
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return invitations.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var invitation = invitations[indexPath.row]
        invitation.confirmationStatus = MOInvitationStatusArrived
        collectionView.reloadData()
    }
    
}
