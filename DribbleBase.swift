//
//  DribbbleBaseObject.swift
//  003-Dribbble-Client
//
//  Created by Audrey Li on 3/14/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import Foundation

class DribbbleBase {
    
    var id: Int
    
    init(data: NSDictionary){
        self.id = data["id"] as! Int
    }

}
