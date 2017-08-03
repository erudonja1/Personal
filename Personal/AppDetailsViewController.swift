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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AppDetailsViewController.addBundle))
        bundlesTable.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        taglineText.scrollRangeToVisible(NSRange(location:0, length:0))
        bundlesTable.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "BundleCell", for: indexPath) as! BundleTableViewCell
        cell.nameLabel!.text = currentUseCase!.bundles[indexPath.row].name
        cell.descriptionLabel!.text = currentUseCase!.bundles[indexPath.row].description
        cell.arrowLabel.font = UIFont.fontAwesome(ofSize: 20)
        cell.arrowLabel.text = String.fontAwesomeIcon(code: "fa-angle-right")
        cell.arrowLabel.textColor = UIColor(hex: "#2e3e4d")
        if currentUseCase!.bundles[indexPath.row].iconImage == nil {
            imgService.getBundleImage(currentUseCase!.bundles[indexPath.row].id, completionHandler: {(img, requestId) in
                if img != nil && requestId == currentUseCase!.bundles[indexPath.row].id  {
                    cell.iconImage?.image = img
                    currentUseCase!.bundles[indexPath.row].iconImage = img
                    self.bundlesTable.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                } else {
                    cell.iconImage?.image = UIImage()
                }
            })
        }else{
            cell.iconImage?.image = currentUseCase!.bundles[indexPath.row].iconImage
        }
        cell.iconImage?.layer.cornerRadius = 8.0
        cell.iconImage?.clipsToBounds = true
        cell.layoutMargins = UIEdgeInsets.zero;
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUseCase!.bundles.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let cell = bundlesTable.cellForRow(at: indexPath)! as! BundleTableViewCell
        currentBundle = currentUseCase!.bundles.filter({$0.name == cell.nameLabel!.text}).first
        if currentBundle != nil{
            self.performSegue(withIdentifier: "showBundleDetails", sender: self)
        }

    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55;
    }
    
    func setConstraints(){}
    func addBundle(){
         self.performSegue(withIdentifier: "createNewBundle", sender: self)
    }
    
}

