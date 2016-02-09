//
//  AppDetailsViewController.swift
//  Personal
//
//  Created by mac on 05/02/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import UIKit
var currentUseCase: Usecase?

class AppDetailsViewController: UITableViewController  {
    
    
    @IBOutlet var bundlesTable: UITableView!
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var taglineText: UITextView!
    @IBOutlet weak var headerView: UIView!
    var imgService = ImageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taglineText.text = currentUseCase?.description
        self.title = currentUseCase?.name
        let imgService = ImageService();
        imgService.getAppImage(currentUseCase!.id, completionHandler: {(img) in
            if img != nil {
                self.icon?.image = img
                self.icon?.layer.cornerRadius = 8.0
                self.icon?.clipsToBounds = true
                self.bundlesTable.reloadData()
            } else {
                print("Error: GET image from service")
                self.icon?.image = UIImage()
            }
        })
        self.view.backgroundColor = UIColor(hex:"#DBE0E4")
        self.headerView.backgroundColor = UIColor(hex:"#DBE0E4")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addBundle")
        bundlesTable.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        taglineText.scrollRangeToVisible(NSRange(location:0, length:0))
        bundlesTable.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier( "BundleCell", forIndexPath: indexPath) as! BundleTableViewCell
        cell.nameLabel!.text = currentUseCase!.bundles[indexPath.row].name
        cell.descriptionLabel!.text = currentUseCase!.bundles[indexPath.row].description
        cell.arrowLabel.font = UIFont.fontAwesomeOfSize(20)
        cell.arrowLabel.text = String.fontAwesomeIconWithCode("fa-angle-right")
        cell.arrowLabel.textColor = UIColor(hex: "#2e3e4d")
        if currentUseCase!.bundles[indexPath.row].iconImage == nil {
            imgService.getBundleImage(currentUseCase!.bundles[indexPath.row].id, completionHandler: {(img, requestId) in
                if img != nil && requestId == currentUseCase!.bundles[indexPath.row].id  {
                    cell.iconImage?.image = img
                    currentUseCase!.bundles[indexPath.row].iconImage = img
                    self.bundlesTable.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                } else {
                    cell.iconImage?.image = UIImage()
                }
            })
        }else{
            cell.iconImage?.image = currentUseCase!.bundles[indexPath.row].iconImage
        }
        cell.iconImage?.layer.cornerRadius = 8.0
        cell.iconImage?.clipsToBounds = true
        cell.layoutMargins = UIEdgeInsetsZero;
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUseCase!.bundles.count
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let cell = bundlesTable.cellForRowAtIndexPath(indexPath)! as! BundleTableViewCell
        currentBundle = currentUseCase!.bundles.filter({$0.name == cell.nameLabel!.text}).first
        if currentBundle != nil{
            self.performSegueWithIdentifier("showBundleDetails", sender: self)
        }

    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55;
    }
    
    func setConstraints(){}
    func addBundle(){
         self.performSegueWithIdentifier("createNewBundle", sender: self)
    }
    
}

