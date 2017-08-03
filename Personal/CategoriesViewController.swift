//
//  MainViewController.swift
//  Personal
//
//  Created by mac on 26/01/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import UIKit
import Spring

class CategoriesViewController: UITableViewController {
    
    @IBOutlet var categoriesTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barTintColor = UIColor(hex: "#2e3e4d")
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(hex:"#DBE0E4")]
        categories = []
        DataAPI().getCategories(self.view, completionHandler: {(str) in
            if str == true {
                self.categoriesTable.reloadData()
            } else {
                print("Error: GET categories from service")
            }
        })
        DataAPI().getUseCases(self.view, completionHandler: {(str) in
            if str == false{
                print("Error: GET useCases from service")
            }
        })
        
        self.view.backgroundColor = UIColor(hex:"#DBE0E4")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        cell.Name!.text = categories![indexPath.row].name
        cell.Name!.textColor = UIColor(hex: "#2e3e4d")
        cell.Icon.font = UIFont.fontAwesome(ofSize: 25)
        cell.Icon.text = String.fontAwesomeIcon(code: categories![indexPath.row].iconName)
        cell.Icon.textColor = UIColor(hex:"#2e3e4d")
        cell.Arrow.font = UIFont.fontAwesome(ofSize: 20)
        cell.Arrow.text = String.fontAwesomeIcon(code: "fa-angle-right")
        cell.Arrow.textColor = UIColor(hex: "#2e3e4d")
        
        cell.backgroundColor = UIColor(hex:"#DBE0E4")
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCategory = categories![indexPath.row]
        self.performSegue(withIdentifier: "showCategoryDetails", sender: self)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories!.count
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
