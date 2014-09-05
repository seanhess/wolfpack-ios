//
//  PlayDatesViewController.swift
//  Wolf Pack
//
//  Created by Sean Hess on 9/4/14.
//  Copyright (c) 2014 Orbital Labs. All rights reserved.
//

import Foundation

import UIKit

class PlayDatesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "PlayDate")
        
        MOUser.loadUsers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.dates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var date = mockData.dates[indexPath.row]
        var cell:UITableViewCell = self.tableView?.dequeueReusableCellWithIdentifier("PlayDate") as UITableViewCell
        cell.textLabel?.text = date.parent.fullName
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("SELECTED ROW")
        self.performSegueWithIdentifier("DateSegue", sender: nil)
//        var vc = PlayDateViewController()
//        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    
    @IBAction func doTap(x:UIButton) {
        println("Tapped: \(x)")
    }
}

