//
//  AppsViewController.swift
//  Personal
//
//  Created by mac on 29/01/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import UIKit

var currentCategory: Category?
class AppsViewController: UITableViewController {
    
    @IBOutlet var appsTable: UITableView!
    var imgService = ImageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = currentCategory?.name
        self.view.backgroundColor = UIColor(hex:"#DBE0E4")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "UseCaseCell", for: indexPath) as! UseCaseTableViewCell
        
        cell.Name!.text = currentCategory!.useCases[indexPath.row].name
        cell.Name!.textColor = UIColor(hex: "#2e3e4d")
        cell.Arrow.font = UIFont.fontAwesome(ofSize: 20)
        cell.Arrow.text = String.fontAwesomeIcon(code: "fa-angle-right")
        cell.Arrow.textColor = UIColor(hex: "#2e3e4d")
        cell.backgroundColor = UIColor(hex:"#DBE0E4")
        
        if currentCategory!.useCases[indexPath.row].iconImage == nil {
            imgService.getAppImage(currentCategory!.useCases[indexPath.row].id, completionHandler: {(img) in
                if img != nil {
                    cell.Icon?.image = img
                    currentCategory!.useCases[indexPath.row].iconImage = img
                    self.appsTable.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                } else {
                    cell.imageView?.image = UIImage()
                }
            })
        }else{
            cell.Icon?.image = currentCategory!.useCases[indexPath.row].iconImage
        }
        cell.Icon?.layer.cornerRadius = 8.0
        cell.Icon?.clipsToBounds = true
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let cell = appsTable.cellForRow(at: indexPath)! as! UseCaseTableViewCell
        currentUseCase = useCases?.filter({$0.name == cell.Name!.text}).first
        if currentUseCase == nil{
            currentUseCase = currentCategory!.useCases.filter({$0.name == cell.Name!.text}).first
        }
        self.performSegue(withIdentifier: "showAppDetails", sender: self)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCategory!.useCases.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
