//
//  BundleCreateViewController.swift
//  Personal
//
//  Created by mac on 05/02/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import UIKit

class BundleCreateViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var newBundle = Bundle(id: "",name: "",description: "")
    var imgService = ImageService()
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var iconImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(BundleCreateViewController.done))
        idTextField.addTarget(self, action: #selector(BundleCreateViewController.idFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        disableFields()
        idTextField.delegate = self
        nameTextField.delegate = self
        descriptionText.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    func idFieldDidChange(_ textField: UITextField){
        clearFields()
        if idTextField.text! != newBundle.id
        {
            newBundle = Bundle(id: idTextField.text!,name: "",description: "")
            imgService.getBundleImage(idTextField.text!, completionHandler: {(img, requestId) in
                if requestId == self.idTextField.text!
                {
                    if img != nil {
                        self.enableFields()
                        self.iconImage?.image = img
                        self.iconImage?.layer.cornerRadius = 8.0
                        self.iconImage?.clipsToBounds = true
                    } else {
                        self.disableFields()
                        print("Error: GET image from service")
                        self.iconImage?.image = UIImage()
                    }}
                self.view.reloadInputViews()
            })
        }
    }
    func clearFields(){
        nameTextField.text = ""
        descriptionText.text = ""
        iconImage.image = UIImage()
    }
    func enableFields(){
        nameTextField.isEnabled = true
        descriptionText.isEditable = true
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    func disableFields(){
        nameTextField.isEnabled = false
        descriptionText.isEditable = false
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    func done(){
        newBundle = Bundle(id: idTextField.text!,name: nameTextField.text!,description: descriptionText.text)
        (useCases?.filter({$0.name == currentUseCase!.name}).first)?.bundles.append(newBundle)
        
        let uCname = currentUseCase!.name
        
        //refresh UseCase
        currentUseCase = useCases?.filter({$0.name == currentUseCase!.name}).first
        if currentUseCase == nil{
            currentUseCase = currentCategory!.useCases.filter({$0.name == uCname}).first
            currentUseCase?.bundles.append(newBundle)
            useCases?.append(currentUseCase!)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}
