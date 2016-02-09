//
//  BundleDetailsViewController.swift
//  Personal
//
//  Created by mac on 05/02/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import UIKit
var currentBundle: Bundle?

class BundleDetailsViewController: UIViewController {
    
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = currentBundle?.name
        descriptionText.text = currentBundle?.description
        self.title = "Details"
        let imgService = ImageService();
        imgService.getBundleImage(currentBundle!.id, completionHandler: {(img, id) in
            if img != nil {
                self.iconImage?.image = img
                self.iconImage?.layer.cornerRadius = 8.0
                self.iconImage?.clipsToBounds = true
                self.view.reloadInputViews()
            } else {
                print("Error: GET image from service")
                self.iconImage?.image = UIImage()
            }
        })

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
