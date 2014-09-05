//
//  PlayDateViewController.swift
//  Wolf Pack
//
//  Created by Sean Hess on 9/5/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import UIKit

class PlayDateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var kidsTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.kidsTableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "PlayDateKid")
        println("What is happening here?")
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.kidsTableView?.dequeueReusableCellWithIdentifier("PlayDateKid") as UITableViewCell
        cell.textLabel?.text = "Hello"
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    // in this case, we
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
 