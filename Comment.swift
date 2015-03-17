//
//  Comment.swift
//  003-Dribble-Client
//
//  Created by Audrey Li on 3/15/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import Foundation

class Comment: DribbleBase {
    
    var body : String!
    var date : String!
    var user : User!
    
    override init(data : NSDictionary){
        super.init(data: data)
        
        let bodyHTML = Utils.getStringFromJSON(data, key: "body")
        self.body = Utils.stripHTML(bodyHTML)
        
        let dateInfo = Utils.getStringFromJSON(data, key: "created_at")
        self.date = Utils.formatDate(dateInfo)
        
        if let userData = data["user"] as? NSDictionary {
            self.user = User(data: userData)
        }
    }
}