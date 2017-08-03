//
//  DataService.swift
//  Personal
//
//  Created by mac on 25/01/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireImage
import MBProgressHUD

var categories: [Category]?
var useCases: [Usecase]?

class DataAPI {
     
    func getCategories(_ forView :UIView, completionHandler: @escaping (Bool) -> ()){
        self.showLoading(forView)
        
        let parameters: Parameters? = nil
        let method: HTTPMethod = .get
        let url: URLConvertible = "https://teamdata.com/s/assets/data/categories.json"
        let headers: HTTPHeaders? = nil
        let encoding: ParameterEncoding = JSONEncoding.default
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON(completionHandler: {(response) in
            categories = []
            if response.error == nil {
                    let json = JSON(response.data!)
                    for (index, element) in json {
                        //create initial Category
                        let cat = Category(id: index, name: element["name"].stringValue,iconName: element["icon"].stringValue ,useCases: [])
                        //parse usecases and append it to Category
                        let uc = element["usecases"]
                        for (_, el) in uc {
                            let uCase = Usecase(id: el["id"].stringValue, name: el["name"].stringValue, description: el["description"].stringValue, links: [], bundles:[])
                            //parse links and append it to UseCase
                            let links = el["links"]
                            for (i, e) in links {
                                let link = Link(id: i, link: e["link"].stringValue, text: e["text"].stringValue, image: e["image"].stringValue)
                                uCase.links.append(link)
                            }
                            cat.useCases.append(uCase)
                        }
                        categories?.append(cat)
                    }
                }
                else {
                    print(response.error ?? "Error")
                }
                self.hideLoading(forView)
                completionHandler(true)
            })
    }
    
    func getUseCases(_ forView :UIView, completionHandler: @escaping (Bool) -> ()){
        self.showLoading(forView)
        
        let parameters: Parameters? = nil
        let method: HTTPMethod = .get
        let url: URLConvertible = "https://teamdata.com/s/assets/data/bundles/usecases.json"
        let headers: HTTPHeaders? = nil
        let encoding: ParameterEncoding = JSONEncoding.default
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON(completionHandler: {(response) in
        useCases = []
            if response.error == nil {
                    let json = JSON(response.data!)
                    for (index, element) in json {
                        //create initial Usecase
                        let usecase = Usecase(id: index, name: element["name"].stringValue, description: element["tagline"].stringValue, links: [], bundles: [])
                        
                        //parse bundles and append it to UseCase
                        let bundles = element["bundles"]
                        for (_, el) in bundles {
                            let bundle = Bundle(id: el["id"].stringValue, name: el["name"].stringValue, description: el["description"].stringValue)
                            usecase.bundles.append(bundle)
                        }
                        
                        useCases?.append(usecase)
                    }
                }
                else {
                     print(response.error ?? "Error")
                }
                self.hideLoading(forView)
                completionHandler(true)
            })
    }
    
    fileprivate func showLoading(_ forView :UIView) {
        let hud = MBProgressHUD.showAdded(to: forView, animated: true)
        hud.label.text = "Loading..."
    }
    fileprivate func hideLoading(_ forView :UIView) {
        MBProgressHUD.hideAllHUDs(for: forView, animated: true)
    }
}



