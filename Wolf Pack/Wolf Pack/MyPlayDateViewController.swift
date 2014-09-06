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
    
    var playDate:MOPlayDate!
    
    var me:MOUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

}
