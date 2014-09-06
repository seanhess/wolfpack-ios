//
//  KidsHomeViewController.swift
//  Wolf Pack
//
//  Created by Sean Hess on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import UIKit
import CoreData

class MainViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet var userBackgroundImageView:UIImageView!
    @IBOutlet var userHeadImageView:UIImageView!
    @IBOutlet var userLabel:UILabel!

    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var viewButton: UIButton!
    
    var me:MOUser!
    var myKidsInvitations:[InvitationStatus] = []
    var playDate:MOPlayDate?
    
    @IBOutlet var collectionView:UICollectionView!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
        // INVITATIONS
        let playDateResults = ModelUtil.execute(MOPlayDate.requestAll()) as [MOPlayDate]
        playDate = playDateResults.first
        viewButton.hidden = playDate == nil
        
        // THE CHILDRENS
        var request = MOChild.childrenRequest(me.id)
        let result = ModelUtil.execute(request) as [MOChild]
        myKidsInvitations = result.map({(child) in InvitationStatus(child: child, invited:false, accepted:false)})
        collectionView.reloadData()
        
        createButton.hidden = kidsInvited().count == 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.allowsMultipleSelection = true
        self.viewButton.hidden = true
        self.createButton.hidden = true
        
        me = MOUser.me()
        
        // BLURRRRY
        var blurEffect = UIBlurEffect(style: .Light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = userBackgroundImageView.bounds
        blurEffectView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        userBackgroundImageView.addSubview(blurEffectView)
        userBackgroundImageView.sd_setImageWithURL(NSURL(string:me.imageUrl))
        
        userHeadImageView.sd_setImageWithURL(NSURL(string:me.imageUrl))
        userLabel.text = me.firstName
    }
    
//    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
//
//    }
    
    /// NSFETCHED RESULTS
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.collectionView.reloadData()
    }

    
    /// TABLE VIEW
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if (indexPath.row == numCells()-1) {
            var cell:UICollectionViewCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("AddKidCell", forIndexPath: indexPath) as UICollectionViewCell
            return cell
        }
        else {
            var cell:ChildHeadCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("ChildHeadCell", forIndexPath: indexPath) as ChildHeadCell
            var status = myKidsInvitations[indexPath.row]
            cell.setData(status.child, selected:status.invited)
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numCells()
    }
    
    func numCells() -> Int {
        return myKidsInvitations.count+1
    }
    
    func kidsInvited() -> [InvitationStatus] {
        return myKidsInvitations.filter({(status) in
            return status.invited
        })
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == numCells()-1) {
            return
        }
        
        var status = myKidsInvitations[indexPath.row]
        status.invited = !status.invited
        createButton.hidden = kidsInvited().count == 0
        self.collectionView.reloadData()
    }
    
    @IBAction func createPlaydate(sender: AnyObject) {
        // load the other screen
        let sb = UIStoryboard(name: "InvitePlayDate", bundle: nil)
        let vc = sb.instantiateInitialViewController() as InvitePlayDateViewController
        vc.myKids = kidsInvited().map({ (status) in
            return status.child
        })
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func viewPlaydate(sender: AnyObject) {
        let sb = UIStoryboard(name: "MyPlayDate", bundle: nil)
        let vc = sb.instantiateInitialViewController() as MyPlayDateViewController
        vc.playDate = playDate!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
