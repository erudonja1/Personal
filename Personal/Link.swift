//
//  Link.swift
//  Personal
//
//  Created by mac on 28/01/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import Foundation

class Link {
    
    var id: String
    var link: String
    var text: String?
    var iconName: String?
    
    
    init(id: String, link: String, text: String?, image:String?) {
        self.id = id
        self.link = link
        self.text = text
        self.iconName = image
    }
}