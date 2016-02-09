//
//  DataService.swift
//  Personal
//
//  Created by mac on 25/01/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
import AlamofireImage
import MBProgressHUD

//global data
var categories: [Category]?
var useCases: [Usecase]?

class DataService {
    
    //constructor
    func DataService(){
    }
    
    
    func getCategories(forView :UIView, completionHandler: (Bool) -> ()){
        self.showLoading(forView)
        Alamofire.request(.GET, "https://www.personal.com/s/assets/data/categories.json", parameters: nil)
            .responseSwiftyJSON({ (request, response, json, error) in
                if error == nil {
                    categories = []
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
                    print(error)
                }
                self.hideLoading(forView)
                completionHandler(true)
            })
    }
    
    func getUseCases(forView :UIView){
        self.showLoading(forView)
        Alamofire.request(.GET, "https://www.personal.com/s/assets/data/bundles/usecases.json", parameters: nil)
            .responseSwiftyJSON({ (request, response, json, error) in
                if error == nil {
                    useCases = []
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
                    print(error)
                }
                self.hideLoading(forView)
            })
    }
    
    private func showLoading(forView :UIView) {
        let hud = MBProgressHUD.showHUDAddedTo(forView, animated: true)
        hud.labelText = "Loading..."
    }
    private func hideLoading(forView :UIView) {
        MBProgressHUD.hideAllHUDsForView(forView, animated: true)
    }
}



