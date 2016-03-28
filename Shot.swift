//
//  Shot.swift
//  003-Dribbble-Client
//
//  Created by Audrey Li on 3/14/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import Foundation

class Shot: DribbbleBase {
    
    var title : String!
    var date : String!
    var description : String!
    var commentCount : Int!
    var likesCount :  Int!
    var viewsCount : Int!
    var commentUrl : String!
    var imageUrl : String!
    var imageData : NSData?
    var user: User!
    
    
    override init(data: NSDictionary){
        super.init(data: data)
        self.commentCount = data["comments_count"] as! Int
        self.likesCount = data["likes_count"] as! Int
        self.viewsCount = data["views_count"] as! Int
        
        self.commentUrl = Utils.getStringFromJSON(data, key: "comments_url")
        self.title = Utils.getStringFromJSON(data, key: "title")
        
        let dateInfo = Utils.getStringFromJSON(data, key: "created_at")
        self.date = Utils.formatDate(dateInfo)
        
        let desc = Utils.getStringFromJSON(data, key: "description")
        self.description = Utils.stripHTML(desc)
        
        let images = data["images"] as! NSDictionary
        self.imageUrl = Utils.getStringFromJSON(images, key: "normal")
        
        if let userData = data["user"] as? NSDictionary {
            self.user = User(data: userData)
        }

    }

}
