//
//  DataService.swift
//  Personal
//
//  Created by mac on 25/01/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

let imageCache = AutoPurgingImageCache(
    memoryCapacity: 100 * 1024 * 1024,
    preferredMemoryUsageAfterPurge: 60 * 1024 * 1024
)

class ImageService {
    
    //constructor
    func ImageService(){
    }
    
    
    
    func getAppImage(id :String, completionHandler: (UIImage?) -> ()){
        //if that image is in cache already
        if let im = imageCache.imageWithIdentifier(id) {
            completionHandler(im)
        }
        else {
            //if it is not, go for it on web...
            Alamofire.request(.GET, "https://www.personal.com/s/assets/files/bundles/apps/\(id)/icon.png").validate(contentType: ["image/*"]).responseImage {response in
                if response.2.isSuccess == true {
                    imageCache.addImage(response.2.value!, withIdentifier: id)
                    completionHandler(response.2.value!)
                } else {
                    completionHandler(UIImage())
                }
            }
        }
    }
    
    func getBundleImage(id :String, completionHandler: (UIImage?, String) -> ()){
        //if that image is in cache already
        if let im = imageCache.imageWithIdentifier(id) {
            completionHandler(im, id)
        }
        else {
            //if it is not, go for it on web...
            Alamofire.request(.GET, "https://www.personal.com/s/assets/files/bundles/templates/\(id).png").validate(contentType: ["image/*"]).responseImage {response in
                if response.2.isSuccess == true {
                    imageCache.addImage(response.2.value!, withIdentifier: id)
                    completionHandler(response.2.value!, id)
                } else {
                    completionHandler(nil,id)
                }
            }
        }
    }
    
}



