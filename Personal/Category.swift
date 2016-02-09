//
//  Category.swift
//  Personal
//
//  Created by mac on 28/01/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import Foundation
import UIKit

class Category {
    
    var id: String
    var name: String
    var iconName: String
    var useCases: [Usecase]
    
    init(id: String, name: String, iconName: String, useCases: [Usecase]) {
        self.id = id
        self.name = name
        self.iconName = iconName
        self.useCases = useCases
    }
}