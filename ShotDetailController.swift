//
//  CollectionViewController.swift
//  003-Dribbble-Client
//
//  Created by Audrey Li on 3/15/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import Foundation
import UIKit

class ShotDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var titleLabel : UILabel!
//    @IBOutlet var dateLabel : UILabel!
    @IBOutlet var topImageView : UIImageView!
//    @IBOutlet var dateImageView : UIImageView!
    
    @IBOutlet var backbutton : UIButton!

    @IBOutlet var profileImageView : UIImageView!
    @IBOutlet var nameLabel : UILabel!
    
    @IBOutlet var commentTableView : UITableView!
    
    @IBOutlet var viewsCount : UILabel!
    @IBOutlet var viewsLabel : UILabel!
    @IBOutlet var likesCount : UILabel!
    @IBOutlet var likesLabel : UILabel!
    @IBOutlet var commentsCount : UILabel!
    @IBOutlet var commentsLabel : UILabel!
    
    @IBOutlet var topImageViewHeightConstraint : NSLayoutConstraint!
 
    var shot: Shot!
    var comments: [Comment] = [Comment](){
        didSet { self.commentTableView.reloadData() }
    }
    
    
    private struct UICONFIG{
        static let statsCountFontSize : CGFloat = 16
        static let statsLabelFontSize : CGFloat = 12
        static let statsCountColor = UIColor(red: 0.32, green: 0.61, blue: 0.94, alpha: 1.0)
        static let statsLabelColor = UIColor(white: 0.7, alpha: 1.0)
    }
    
    var transitionOperator = TransitionOperator()
    func setShot(shots:[Shot]){
        self.shot = shots[1]
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = shot.title
        
        titleLabel.font = UIFont(name: Theme.fontName, size: 21)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = shot.title
        
//        dateLabel.font = UIFont(name: Theme.fontName, size: 10)
//        dateLabel.textColor = UIColor.whiteColor()
//        dateLabel.text = shot.date
//        
//        dateImageView.image = UIImage(named: "clock")?.imageWithRenderingMode(.AlwaysTemplate)
//        dateImageView.tintColor = UIColor.whiteColor()
        
        if let imageData = shot.imageData {
            topImageView.image = UIImage(data: imageData)
        }else{
            DribbbleObjectHandler.asyncLoadShotImage(shot, imageView: topImageView)
        }
        
        
//        topImageViewHeightConstraint.constant = 240
        
        nameLabel.font = UIFont(name: Theme.fontName, size: 16)
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.text = "by \(shot.user.name)"
        
        DribbbleObjectHandler.asyncLoadUserImage(shot.user, imageView: profileImageView)
 
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true // By default it is false
        
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "profileTapped")
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        nameLabel.userInteractionEnabled = true
        nameLabel.addGestureRecognizer(tapGesture)
        
        profileImageView.userInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGesture)
        
        
        viewsCount.font = UIFont(name: Theme.boldFontName, size: UICONFIG.statsCountFontSize)
        viewsCount.textColor = UICONFIG.statsCountColor
        viewsCount.text = "\(shot.viewsCount)"
        
        viewsLabel.font = UIFont(name: Theme.fontName, size: UICONFIG.statsLabelFontSize)
        viewsLabel.textColor = UICONFIG.statsLabelColor
        viewsLabel.text = "VIEWS"
        
        likesCount.font = UIFont(name: Theme.boldFontName, size: UICONFIG.statsCountFontSize)
        likesCount.textColor = UICONFIG.statsCountColor
        likesCount.text = "\(shot.likesCount)"
        
        likesLabel.font = UIFont(name: Theme.fontName, size: UICONFIG.statsLabelFontSize)
        likesLabel.textColor = UICONFIG.statsLabelColor
        likesLabel.text = "LIKES"
        
        commentsCount.font = UIFont(name: Theme.boldFontName, size: UICONFIG.statsCountFontSize)
        commentsCount.textColor = UICONFIG.statsCountColor
        commentsCount.text = "\(shot.commentCount)"
        
        commentsLabel.font = UIFont(name: Theme.fontName, size: UICONFIG.statsLabelFontSize)
        commentsLabel.textColor = UICONFIG.statsLabelColor
        commentsLabel.text = "COMMENTS"
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.estimatedRowHeight = 100.0
        commentTableView.rowHeight = UITableViewAutomaticDimension

        
        let commentURL = shot.commentUrl + "?access_token=" + Config.ACCESS_TOKEN
        
        DribbbleObjectHandler.getComments(shot.commentUrl, callback: { (comments) -> Void in
            self.comments = comments
        })
  

        var tapGestureZoom = UITapGestureRecognizer(target: self, action: "zoomShot:")
        tapGestureZoom.numberOfTapsRequired = 1
        tapGestureZoom.numberOfTouchesRequired = 1
        topImageView.userInteractionEnabled = true
        topImageView.addGestureRecognizer(tapGestureZoom)
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
//        addShotGradient()
    }
    
//    func addShotGradient(){
//        
//        topGradientView.clipsToBounds = true
//        
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = CGRectMake(0, 0, self.view.frame.width, 90)
//        gradientLayer.colors = [UIColor(white: 0.0, alpha: 0.0).CGColor, UIColor(white: 0.0, alpha: 0.5).CGColor]
//        
//        self.topGradientView.layer.addSublayer(gradientLayer)
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  
        var cell = tableView.dequeueReusableCellWithIdentifier("commentCell") as! CommentCell
        
        let comment = comments[indexPath.row]
        
        cell.nameLabel.text = comment.user.name
        cell.postLabel?.text = comment.body
        cell.dateLabel.text = comment.date
        
        DribbbleObjectHandler.asyncLoadUserImage(comment.user, imageView: cell.profileImageView)

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    

    func backTapped(sender: AnyObject?){
        dismissViewControllerAnimated(true, completion: nil)
    }
    func profileTapped(){
        performSegueWithIdentifier("profile", sender: self)
    }
    
  
    //check later how to implement
    @IBAction func zoomShot(sender: AnyObject?){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("ShotZoomController") as! ShotZoomController
        self.modalPresentationStyle = UIModalPresentationStyle.Custom
        controller.transitioningDelegate = transitionOperator
        controller.shot = shot
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "profile" {
            let controller = segue.destinationViewController as! ProfileViewController
            
            controller.user = shot.user
        }
    }
}
