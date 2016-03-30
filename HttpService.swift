//
//  HttpService.swift
//  003-Dribbble-Client
//
//  Created by Audrey Li on 3/14/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import Foundation
import UIKit

class HttpService {

    class func getJSON(url: String, callback:((NSArray) -> Void)){
        let nsURL = NSURL(string: url)!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(nsURL, completionHandler: { data, response, error -> Void in
            if error != nil {
                print("error !")
            } else {
                do{
                    if let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray {
                        callback(jsonData)
                    }

                } catch let error as NSError {
                    print(error)
                }
                
            }
        })
        task.resume()
    }
    
    class func asyncLoadImage(url: String, imageView: UIImageView, callback:((NSData) -> Void)){
        
        let downloadQueue = dispatch_queue_create("com.shomigo.processsdownload", nil)
        
        dispatch_async(downloadQueue) {
            let data = NSData(contentsOfURL: NSURL(string: url)!)
            var image : UIImage?
            if data != nil {
                image = UIImage(data: data!)!
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
        
    }
    
}