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
        didSet{
            self.collectionView?.reloadData()
        }
    }
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    var shotPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.backgroundColor = UIColor.whiteColor()

        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier1)
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        
//        let cellWidth = calcCellWidth(self.view.frame.size)
        
        let cellWidth = self.view.bounds.width
        let cellHeight = cellWidth * 9 / 10
        layout.itemSize = CGSizeMake(cellWidth, cellHeight)
        
        
        
//        let url = Config.SHOT_URL + Config.ACCESS_TOKEN
        
        DribbbleObjectHandler.getShots(Config.SHOT_URL, page: 1,  callback: { (shots) -> Void in
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
        
//        DribbbleObjectHandler.asyncLoadShotImage(shot, imageView: cell.imageView)
//        DribbbleObjectHandler.asyncLoadUserImage(shot.user, imageView: cell.avatar)
        
        cell.imageView.sd_setImageWithURL(NSURL(string: shot.imageUrl)!)
        cell.avatar.sd_setImageWithURL(NSURL(string: shot.user.avatarUrl)!)
        
        cell.avatar.layer.cornerRadius = cell.avatar.bounds.width / 2
        cell.avatar.layer.masksToBounds = true
        
        //如果 shot 数量减 1 等于位置行数 且 shotPage 小于 5，则请求 shot 加到后面
        if shots.count - 1 == indexPath.row && shotPages < 5 {
            shotPages = shotPages + 1
            print(shotPages)
//            let url = Config.SHOT_URL +
            
            DribbbleObjectHandler.getShots(Config.SHOT_URL, page:shotPages, callback: {(shots) -> Void in
//                                self.shots = shots
                
                for shot in shots {
                    self.shots.append(shot)
                }
            })
        }

    
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
