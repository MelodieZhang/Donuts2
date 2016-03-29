//
//  HttpService.swift
//  003-Dribbble-Client
//
//  Created by Audrey Li on 3/14/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import Foundation
import UIKit

// Need to update the file later once I learned more about multi-thread 
class DribbbleObjectHandler {
    
    class func asyncLoadShotImage(shot: Shot, imageView : UIImageView){
        
        let downloadQueue = dispatch_queue_create("com.shomigo.processsdownload", nil)
        
        dispatch_async(downloadQueue) {
            
            var data = NSData(contentsOfURL: NSURL(string: shot.imageUrl)!)
            
            var image : UIImage?
            if data != nil {
                shot.imageData = data
                image = UIImage(data: data!)!
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
    }
    
    class func asyncLoadUserImage(user: User, imageView : UIImageView){
        
        let downloadQueue = dispatch_queue_create("com.shomigo.processsdownload", nil)
        
        dispatch_async(downloadQueue) {
            
            var data = NSData(contentsOfURL: NSURL(string: user.avatarUrl)!)
            
            var image : UIImage?
            if data != nil {
                image = UIImage(data: data!)!
                user.avatarData = data
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
    }
    

    
//    class func getShots(dataArray: NSArray, callback:(([Shot]) -> Void)!){
//        var shots = [Shot]()
//        for shotData in dataArray {
//            let shot = Shot(data: shotData as NSDictionary)
//            shots.append(shot)
//        }
//        
//        callback(shots)
//        
//        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//        dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                callback(shots)
//            })
//        })
//        
//    }

    class func getShots(url: String, page: Int, callback:(([Shot]) -> Void)){
        var shots = [Shot]()
        var url = url + "?access_token=" + Config.ACCESS_TOKEN + "&page=" + String(page)
        HttpService.getJSON(url) { (jsonData) -> Void in
            for shotData in jsonData {
                let shot = Shot(data: shotData as! NSDictionary)
                shots.append(shot)
            }
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    callback(shots)
        
                })
            })
        }
        
    }
    
    class func getUsers(url: String, callback:(([User]) -> Void)){
        var users = [User]()
        var url = url + "?access_token=" + Config.ACCESS_TOKEN
        HttpService.getJSON(url, callback: { (jsonData) -> Void in
            for userData in jsonData {
                
                let user = User(data: userData["followee"] as! NSDictionary)
                
                users.append(user)
                
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        callback(users)
                    })
                })
            }
        })
        
    }
    
    
    class func getComments(url: String, callback:(([Comment]) -> Void)!) {

        var comments = [Comment]()
        var url = url + "?access_token=" + Config.ACCESS_TOKEN
        
        HttpService.getJSON(url, callback: { (jsonData) -> Void in
            for commentData in jsonData {
                let comment = Comment(data: commentData as! NSDictionary)
                comments.append(comment)
                
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        callback(comments)
                    }
                }
            }
        })
        
    }
}