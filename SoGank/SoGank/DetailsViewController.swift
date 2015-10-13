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

class DetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    /**
        数据详情表
    */
    @IBOutlet weak var detailsTable: UITableView!
    var searchDate = ""
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
                sself.showData.append(shows)
                sself.detailsTable.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: tableview
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch showData[0].category[section] {
            case "福利":
                return showData[0].results.福利.count
            case "Android":
                return showData[0].results.Android.count
            case "iOS":
                return showData[0].results.iOS.count
            case "休息视频":
                return showData[0].results.休息视频.count
            case "拓展资源":
                return showData[0].results.拓展资源.count
            case "前端":
                return showData[0].results.前端.count
            case "瞎推荐":
                return showData[0].results.瞎推荐.count
            default:
                break
        }
        return 0
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
        return  showData[0].category[section];
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard showData[0].category[indexPath.section] == "福利" else {
            return 44.0;
        }
        return 100.0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailsCell", forIndexPath: indexPath) as UITableViewCell
        
        let tStr = showData[0].category[indexPath.section]
        if tStr == "福利" {
            let tmp = showData[0].results.福利[indexPath.row]
            cell.textLabel?.text = tmp.desc
        }
        else if tStr == "Android" {
            let tmp = showData[0].results.Android[indexPath.row]
            cell.textLabel?.text = tmp.desc
        }
        else if tStr == "iOS" {
            let tmp = showData[0].results.iOS[indexPath.row]
            cell.textLabel?.text = tmp.desc
        }
        else if tStr == "休息视频" {
            let tmp = showData[0].results.休息视频[indexPath.row]
            cell.textLabel?.text = tmp.desc
        }
        else if tStr == "拓展资源" {
            let tmp = showData[0].results.拓展资源[indexPath.row]
            cell.textLabel?.text = tmp.desc
        }
        else if tStr == "前端" {
            let tmp = showData[0].results.前端[indexPath.row]
            cell.textLabel?.text = tmp.desc
        }
        else if tStr == "瞎推荐" {
            let tmp = showData[0].results.瞎推荐[indexPath.row]
            cell.textLabel?.text = tmp.desc
        }
        return cell
    }
    

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
