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
    
    func getAppImage(_ id :String, completionHandler: @escaping (UIImage?) -> ()){
        //if that image is in cache already
        if let im = imageCache.image(withIdentifier: id){
            completionHandler(im)
        }
        else {
            
            //if it is not, go for it on web...
            let parameters: Parameters? = nil
            let method: HTTPMethod = .get
            let url: URLConvertible =  "https://www.teamdata.com/s/assets/files/bundles/apps/\(id)/icon.png"
            let headers: HTTPHeaders? = nil
            let encoding: ParameterEncoding = JSONEncoding.default
            Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate(contentType: ["image/*"]).responseImage {response in
                if response.result.isSuccess == true {
                    imageCache.add(response.value!, withIdentifier: id)
                    completionHandler(response.value!)
                } else {
                    completionHandler(UIImage())
                }
            }
        }
    }
    
    func getBundleImage(_ id :String, completionHandler: @escaping (UIImage?, String) -> ()){
        //if that image is in cache already
        if let im = imageCache.image(withIdentifier: id){
            completionHandler(im, id)
        }
        else {
            //if it is not, go for it on web...
            let parameters: Parameters? = nil
            let method: HTTPMethod = .get
            let url: URLConvertible =  "https://www.teamdata.com/s/assets/files/bundles/templates/\(id).png"
            let headers: HTTPHeaders? = nil
            let encoding: ParameterEncoding = JSONEncoding.default
            
            Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate(contentType: ["image/*"]).responseImage {response in
                if response.result.isSuccess == true {
                    imageCache.add(response.value!, withIdentifier: id)
                    completionHandler(response.value!, id)
                } else {
                    completionHandler(nil,id)
                }
            }
        }
    }
    
}



