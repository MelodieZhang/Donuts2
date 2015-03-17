//
//  DribbleBaseObject.swift
//  003-Dribble-Client
//
//  Created by Audrey Li on 3/14/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import Foundation

class DribbleBase {
    
    var id: Int
    
    init(data: NSDictionary){
        self.id = data["id"] as Int
    }

}
