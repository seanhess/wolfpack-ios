//
//  MyPlayDateViewController.swift
//  Wolf Pack
//
//  Created by George Shank on 9/6/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import UIKit
import CoreData

class MyPlayDateViewController: UIViewController, NSFetchedResultsControllerDelegate,UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var userBackgroundImageView:UIImageView!
    @IBOutlet var userHeadImageView:UIImageView!
    @IBOutlet var userLabel:UILabel!
    
    var me:MOUser!
    var fetchedResults:NSFetchedResultsController?
    
    var currentPlayDate:MOPlayDate?
    
    var selectedChildren:[String : MOChild]!
    
    @IBOutlet var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedChildren = [:]
        
        self.collectionView.allowsMultipleSelection = true
        
        me = MOUser.me()
        currentPlayDate = MOPlayDate.create(NSDate(), location: "", owner: me)
        
        // BLURRRRY
        var blurEffect = UIBlurEffect(style: .Light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = userBackgroundImageView.bounds
        blurEffectView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        userBackgroundImageView.addSubview(blurEffectView)
        userBackgroundImageView.sd_setImageWithURL(NSURL(string:me.imageUrl))
        
        userHeadImageView.sd_setImageWithURL(NSURL(string:me.imageUrl))
        
        //userLabel.text = me.firstName
        println("USER \(me.firstName)")
        
        // Hide navigation bar
        self.navigationController?.navigationBarHidden = true
        
        // THE CHILDRENS
        var error:NSError?
        self.fetchedResults = NSFetchedResultsController(fetchRequest: MOChild.childrenRequest(me.id), managedObjectContext: ModelUtil.defaultMOC, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResults?.delegate = self
        self.fetchedResults?.performFetch(&error)
        // Do any additional setup after loading the view.
    }
    
    /// NSFETCHED RESULTS
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// TABLE VIEW
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:ChildHeadCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("ChildHeadCell", forIndexPath: indexPath) as ChildHeadCell
        var maybeChild = self.fetchedResults?.objectAtIndexPath(indexPath) as MOChild?
        if let child = maybeChild {
            cell.setData(child, selected:isSelected(child))
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numCells()
    }
    
    func numCells() -> Int {
        if let sections = self.fetchedResults?.sections {
            var section = sections[0] as NSFetchedResultsSectionInfo
            return section.numberOfObjects
        }
        return 0
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == numCells()) {
            return
        }
        
        println("select \(indexPath)")
        
        var child = self.fetchedResults?.objectAtIndexPath(indexPath)! as MOChild
        
        if let value = self.selectedChildren[child.id] {
            self.selectedChildren[child.id] = nil
        }
        else {
            self.selectedChildren[child.id] = child
        }
        
        self.collectionView.reloadData()
    }
    
    func isSelected(child:MOChild) -> Bool {
        if let value = self.selectedChildren[child.id] {
            return true
        }
        return false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
