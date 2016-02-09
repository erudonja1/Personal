//  Personal
//
//  Created by mac on 28/01/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//
import UIKit
import Foundation
class Bundle {
    
    var id: String
    var name: String
    var description: String?
    var iconImage: UIImage?
    
    init(id: String, name: String, description: String?) {
        self.id = id
        self.name = name
        self.description = description
    }
}