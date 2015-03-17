//
//  User.swift
//  003-Dribble-Client
//
//  Created by Audrey Li on 3/15/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import Foundation

class User: DribbleBase {
    
    var avatarUrl : String!
    var name : String!
    var location : String!
    var followingCount : Int!
    var followersCount : Int!
    var shotsCount : Int!
    
    var shotsUrl : String!
    var followingUrl : String!
    
    var avatarData : NSData?
    
    override init(data: NSDictionary){
        super.init(data: data)
        
        self.name = Utils.getStringFromJSON(data, key: "name")
        self.avatarUrl = Utils.getStringFromJSON(data, key: "avatar_url")
        
        self.location = Utils.getStringFromJSON(data, key: "location")
        self.followingCount = data["followings_count"] as Int
        self.followersCount = data["followers_count"] as Int
        self.shotsCount = data["shots_count"] as Int
        
        self.shotsUrl = Utils.getStringFromJSON(data, key: "shots_url")
        self.followingUrl = Utils.getStringFromJSON(data, key: "following_url")
    }
    
}
