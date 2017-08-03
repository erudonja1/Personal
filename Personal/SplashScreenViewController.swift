//
//  SplashScreenViewController.swift
//  Personal
//
//  Created by mac on 26/01/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import UIKit
import Spring
import FontAwesome_swift

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Cloud.font = UIFont.fontAwesome(ofSize: 100)
        Cloud.text = String.fontAwesomeIcon(name: FontAwesome.cloud)
        Cloud.textColor = UIColor(hex:"#F4F5F7")

        //Second way
        //come in
        titleLabel.textColor = UIColor(hex:"#DBE0E4")
        titleLabel.animation = "fadeIn";
        titleLabel.duration = 3;
        titleLabel.autohide = true;
        titleLabel.animate();
        Cloud.animation = "squeezeLeft"
        Cloud.duration = 2;
        Cloud.autohide = true;
        Cloud.animate();

        
        //when animations are finished, do segue and go to initial view
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(SplashScreenViewController.doSegue), userInfo: nil, repeats: true)
    }
    
    func doSegue(){
        self.performSegue(withIdentifier: "showMainView", sender: self)
    }
    
    @IBOutlet weak var Cloud: SpringLabel!
    @IBOutlet weak var titleLabel: SpringLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
}
