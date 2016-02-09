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
        
        //First way
        /*UIView.animateWithDuration(0.7, animations: {
        self.titleLabel.center.x += self.view.bounds.width
        }) { (fin) -> Void in
        if fin==true
        {
        self.performSegueWithIdentifier("showMainView", sender: self)
        }
        }*/
        
        //Second way
        //come in
        titleLabel.textColor = UIColor(hex:"#DBE0E4")
        titleLabel.animation = "fadeIn";
        titleLabel.duration = 3;
        titleLabel.autohide = true;
        titleLabel.animate();
        Cloud.font = UIFont.fontAwesomeOfSize(100)
        Cloud.text = String.fontAwesomeIconWithName(FontAwesome.Cloud)
        Cloud.textColor = UIColor(hex:"#F4F5F7")
        Cloud.animation = "squeezeLeft"
        Cloud.duration = 2;
        Cloud.autohide = true;
        Cloud.animate();
        
        //when animations are finished, do segue and go to initial view
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "doSegue", userInfo: nil, repeats: true)
    }
    
    func doSegue(){
        self.performSegueWithIdentifier("showMainView", sender: self)
    }
    
    @IBOutlet weak var Cloud: SpringLabel!
    @IBOutlet weak var titleLabel: SpringLabel!
    
    override func viewWillAppear(animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    
}
