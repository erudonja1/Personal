//
//  Usecase.swift
//  Personal
//
//  Created by mac on 28/01/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//
import UIKit
import Foundation

class Usecase {
    
    var id: String
    var name: String
    var description: String
    var links: [Link]
    var bundles: [Bundle]
    var iconImage: UIImage?
    
    init(id: String, name: String, description: String,links: [Link], bundles: [Bundle]) {
        self.id = id
        self.name = name
        self.description = description
        self.links = links
        self.bundles = bundles
    }
}