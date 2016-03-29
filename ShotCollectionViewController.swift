//
//  CollectionViewController.swift
//  003-Dribbble-Client
//
//  Created by Audrey Li on 3/15/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import UIKit

let reuseIdentifier1 = "Cell"

class ShotCollectionViewController: UICollectionViewController {
    
    var shots:[Shot] = [Shot]() {
        didSet { self.collectionView?.reloadData() }
    }
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.backgroundColor = UIColor.whiteColor()

        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier1)
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        
//        let cellWidth = calcCellWidth(self.view.frame.size)
        let cellWidth = self.view.bounds.width
        let cellHeight = cellWidth * 9 / 10
        layout.itemSize = CGSizeMake(cellWidth, cellHeight)
        
        
        
        let url = Config.SHOT_URL + Config.ACCESS_TOKEN
        DribbbleObjectHandler.getShots(Config.SHOT_URL, callback: { (shots) -> Void in
            self.shots = shots
        })
        
    }
    

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shots.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ShotCollectionViewCell
        
        let shot = shots[indexPath.row]
//        cell.title.text = shot.title
        cell.name.text = shot.user.name
        cell.likesCount.text = String(shot.likesCount)
        
        DribbbleObjectHandler.asyncLoadShotImage(shot, imageView: cell.imageView)
        DribbbleObjectHandler.asyncLoadUserImage(shot.user, imageView: cell.avatar)
        
        
        cell.avatar.layer.cornerRadius = cell.avatar.bounds.width / 2
        cell.avatar.layer.masksToBounds = true
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("details", sender: self)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "details"{
            let selectedItems = self.collectionView!.indexPathsForSelectedItems()
            let indexPath = selectedItems![0] as NSIndexPath
            let desController: ShotDetailController = segue.destinationViewController as! ShotDetailController
            let shot = shots[indexPath.row]
            desController.shot = shot
        }
    }
    


}
