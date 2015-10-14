//
//  DetailsViewController.swift
//  SoGank
//
//  Created by ule_shengyangyu on 15/10/12.
//  Copyright © 2015年 ule_shengyangyu. All rights reserved.
//

import UIKit
import Foundation
import Pitaya
import Kingfisher

class DetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    /**
        数据详情表
    */
    @IBOutlet weak var detailsTable: UITableView!
    var searchDate = ""
    var pURL = ""
    /**
        Data
    */
    var showData: [SGShowEntiy]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        showData = [SGShowEntiy]()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        showData = [SGShowEntiy]()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = searchDate;
        // Do any additional setup after loading the view.

        GankNetworkUtil.getDateGank(searchDate) {
            [weak self] shows, error in
            if let sself = self {
                guard let index = shows.category.indexOf("福利") else {
                    sself.showData.append(shows)
                    sself.detailsTable.reloadData()
                    return
                }
                shows.category.removeAtIndex(index)
                shows.category.insert("福利", atIndex: 0)
                sself.showData.append(shows)
                sself.detailsTable.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataForType(tStr: String, tIndex:Int) -> SGBaseEntiy? {
        if tStr == "福利" {
            let tmp = showData[0].results.福利[tIndex]
            return tmp
        }
        else if tStr == "Android" {
            let tmp = showData[0].results.Android[tIndex]
            return tmp
        }
        else if tStr == "iOS" {
            let tmp = showData[0].results.iOS[tIndex]
            return tmp
        }
        else if tStr == "休息视频" {
            let tmp = showData[0].results.休息视频[tIndex]
            return tmp
        }
        else if tStr == "拓展资源" {
            let tmp = showData[0].results.拓展资源[tIndex]
            return tmp
        }
        else if tStr == "前端" {
            let tmp = showData[0].results.前端[tIndex]
            return tmp
        }
        else if tStr == "瞎推荐" {
            let tmp = showData[0].results.瞎推荐[tIndex]
            return tmp
        }
        return nil
    }
    
    func getCountForType(tStr: String) -> Int {
        if tStr == "福利" {
            return showData[0].results.福利.count
        }
        else if tStr == "Android" {
            return showData[0].results.Android.count
        }
        else if tStr == "iOS" {
            return showData[0].results.iOS.count
        }
        else if tStr == "休息视频" {
            return showData[0].results.休息视频.count
        }
        else if tStr == "拓展资源" {
            return showData[0].results.拓展资源.count
        }
        else if tStr == "前端" {
            return showData[0].results.前端.count
        }
        else if tStr == "瞎推荐" {
            return showData[0].results.瞎推荐.count
        }
        return 0
    }

    // MARK: tableview
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getCountForType(showData[0].category[section])
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        guard showData.count > 0 else {
            return 0
        }
        guard showData[0].category.count > 0 else {
            return 0
        }
        return showData[0].category.count
    }
   
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return showData[0].category[section]
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        guard showData[0].category[indexPath.section] == "福利" else {
            return 44.0;
        }
        return 200.0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if showData.count == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NothingFound", forIndexPath: indexPath)
            cell.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        } else {
            let tStr = showData[0].category[indexPath.section]
            if let cell = tableView.dequeueReusableCellWithIdentifier("DetailsCell", forIndexPath: indexPath) as? DetailsCell {
                let tmp = getDataForType(tStr,tIndex:indexPath.row)
                if (tStr == "福利" && indexPath.section == 0 && indexPath.row == 0) {
                    cell.bindData(tmp!)
                }
                else {
                    cell.detailImage.hidden = true;
                    let tmp = getDataForType(tStr,tIndex:indexPath.row)
                    cell.textLabel?.text = tmp!.desc
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard (indexPath.section == 0 && indexPath.row == 0) else {
            let tStr = showData[0].category[indexPath.section]
            let tmp = getDataForType(tStr,tIndex:indexPath.row)
            pURL = (tmp?.url)!
            self.performSegueWithIdentifier("webDetails", sender: self)
            return
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc:WebViewController = (segue.destinationViewController as! WebViewController)
        vc.showURL = pURL
    }
}
