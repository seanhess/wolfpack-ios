//
//  InvitePlayDateViewController
//  Wolf Pack
//
//  Created by Sean Hess on 9/6/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import Foundation

class InvitePlayDateViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIAlertViewDelegate, iCarouselDataSource, iCarouselDelegate {
    
    @IBOutlet var myKidsImageView:UIImageView!
    @IBOutlet var collectionView:UICollectionView!
    
    @IBOutlet weak var whereButton: UIButton!
    @IBOutlet weak var whenButton: UIButton!
    @IBOutlet weak var carousel:iCarousel!
    @IBOutlet weak var sendButton:UIButton!
    
    var invitations:[InvitationStatus] = []
    var myKids:[MOChild] = []
    var reallyInvited:[InvitationStatus] = []
    
    var me:MOUser!
    
    override func viewWillAppear(animated: Bool) {

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
        reallyInvited = []
//        collectionView.reloadData()
        
        whereButton.layer.borderColor = WPColorBlue.CGColor
        whereButton.layer.borderWidth = 2
        whereButton.setTitleColor(WPColorBlue, forState: UIControlState.Normal)
        whenButton.layer.borderColor = WPColorBlue.CGColor
        whenButton.layer.borderWidth = 2
        whenButton.setTitleColor(WPColorBlue, forState: UIControlState.Normal)
        
        carousel.type = iCarouselType.Wheel
        carousel.vertical = false
        carousel.delegate = self
        carousel.dataSource = self
        carousel.reloadData()
    
        sendButton.backgroundColor = UIColor.grayColor()
        sendButton.enabled = false
    }
    
    
    /// CAROUSEL
    
    func carousel(carousel: iCarousel!, didSelectItemAtIndex index: Int) {
        var status = invitations[index]
        status.invited = !status.invited
        reallyInvited = reallyInvitedFilter()
        
        if reallyInvited.count > 0 {
            sendButton.backgroundColor = WPColorGreen
            sendButton.enabled = true
        }
        else {
            sendButton.backgroundColor = UIColor.grayColor()
            sendButton.enabled = false
        }
        
        carousel.reloadData()
        collectionView.reloadData()
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView: UIView?) -> UIView {
        var cell:ChildHeadCell
        
        if let value = reusingView {
            cell = value as ChildHeadCell
        }
        else {
            cell = ChildHeadCell(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        }
        
        var status = invitations[index]
        cell.setData(status.child, selected:status.invited)

        return cell;
    }
    
    func numberOfItemsInCarousel(carousel: iCarousel!) -> Int {
        return invitations.count
    }
    
    func carousel(carousel: iCarousel!, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {
            
        case .VisibleItems:
            return 5
            
        case .Radius:
            return 130

        case .Angle:
            return (CGFloat(M_PI) / 5)
            
        default:
            return value
        }
    }
    
    
    
    
    
    
    
    /// TABLE VIEW
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:ChildHeadCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("ChildHeadCell", forIndexPath: indexPath) as ChildHeadCell
        var status = reallyInvited[indexPath.row]
        cell.setData(status.child, selected:status.invited)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reallyInvited.count
    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        var status = invitations[indexPath.row]
//        status.invited = !status.invited
//        collectionView.reloadData()
//    }

    @IBAction func sendInvite(sender: AnyObject) {
        var playDate = MOPlayDate.create(NSDate(), location:"", owner: me)

        var otherInvitations = reallyInvitedFilter()
        .map({(status) in
            return MOInvitation.create(status.child, status: MOInvitationStatusInvited, playDate: playDate)
        }) as [MOInvitation]
        
        var kidInvitations = myKids.map({ (child) in
            return MOInvitation.create(child, status: MOInvitationStatusArrived, playDate: playDate)
        }) as [MOInvitation]
        
        var allInvitations = otherInvitations + kidInvitations
        ModelUtil.commitDefaultMOC()
        MOPlayDate.send(playDate, invitations: allInvitations)

        var alert = UIAlertController(title: "Good Job", message: "Playdate invite was sent.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Return to Home", style: UIAlertActionStyle.Default, handler: {(action) in
            self.navigationController?.popViewControllerAnimated(true)
            return
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func reallyInvitedFilter() -> [InvitationStatus] {
        return invitations.filter({ (status) in
            return status.invited
        })
    }
    
    @IBAction func close(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}