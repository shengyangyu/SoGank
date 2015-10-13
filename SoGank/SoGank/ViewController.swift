//
//  ViewController.swift
//  SoGank
//
//  Created by ule_shengyangyu on 15/10/10.
//  Copyright © 2015年 ule_shengyangyu. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {

    /**
        图片表格
    */
    @IBOutlet weak var gankCollection: UICollectionView!
    /**
        Data
    */
    var ganks: [SGBaseEntiy]
    var page = 1
    var pdate = ""
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        ganks = [SGBaseEntiy]()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        ganks = [SGBaseEntiy]()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GankNetworkUtil.getGanks(page) {
            [weak self] cells, error in
            
            if let sself = self {
                sself.ganks += cells.results
                sself.gankCollection.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: collectview
    // 实现UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return ganks.count;
    }
    
    // 实现UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:GanksCell  = self.gankCollection.dequeueReusableCellWithReuseIdentifier("GanksCell", forIndexPath: indexPath) as! GanksCell
        if (indexPath.row < ganks.count) {
            let entity = ganks[indexPath.row]
            cell.bindData(entity)
        }
        return cell;
    }
    
    // 实现UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let date = ganks[indexPath.row].createdAt//"2015-10-10T03:58:17.761Z"
        if date.characters.count > 10 {
            let ndate = (date as NSString).substringToIndex(10)
            pdate = ndate.stringByReplacingOccurrencesOfString("-", withString: "/", options: .LiteralSearch, range: nil)
        }
        self.performSegueWithIdentifier("showDetails", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc:DetailsViewController = (segue.destinationViewController as! DetailsViewController)
        vc.searchDate = pdate
    }
}

