//
//  MainViewController.swift
//  Personal
//
//  Created by mac on 26/01/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import UIKit
import Spring

class MainViewController: UITableViewController {
    
    @IBOutlet var categoriesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barTintColor = UIColor(hex: "#2e3e4d")
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(hex:"#DBE0E4")]
        let d = DataService()
        d.getCategories(self.view, completionHandler: {(str) in
            if str == true {
                self.categoriesTable.reloadData()
            } else {
                print("Error: GET categories from service")
            }
        })
        d.getUseCases(self.view)
        self.view.backgroundColor = UIColor(hex:"#DBE0E4")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier( "CategoryCell", forIndexPath: indexPath) as! CategoryTableViewCell
        
        cell.Name!.text = categories![indexPath.row].name
        cell.Name!.textColor = UIColor(hex: "#2e3e4d")
        cell.Icon.font = UIFont.fontAwesomeOfSize(25)
        cell.Icon.text = String.fontAwesomeIconWithCode(categories![indexPath.row].iconName)
        cell.Icon.textColor = UIColor(hex:"#2e3e4d")
        cell.Arrow.font = UIFont.fontAwesomeOfSize(20)
        cell.Arrow.text = String.fontAwesomeIconWithCode("fa-angle-right")
        cell.Arrow.textColor = UIColor(hex: "#2e3e4d")
        
        cell.backgroundColor = UIColor(hex:"#DBE0E4")
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentCategory = categories![indexPath.row]
        self.performSegueWithIdentifier("showCategoryDetails", sender: self)
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories!.count
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80;
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
