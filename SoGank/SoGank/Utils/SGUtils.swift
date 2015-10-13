//
//  SGUtils.swift
//  SoGank
//
//  Created by ule_shengyangyu on 15/10/10.
//  Copyright © 2015年 ule_shengyangyu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Pitaya

let DEBUG = true

class GankDateUtil {
    
    static let PAGE_SIZE = 20
    static let API_FORMAT = "yyyy/MM/dd"
    static let MAX_PAGE = 5
    
    class func generateHistoryDateString(page: Int) -> [String] {
        return self.generateHistoryDateString(format: self.API_FORMAT, historyCount: self.PAGE_SIZE, page: page)
    }
    
    class func generateHistoryDateString(format format: String, historyCount: Int, page: Int) -> [String] {
        
        let today = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        
        let unit = ((page - 1) * self.PAGE_SIZE)...(page * self.PAGE_SIZE - 1)
        
        return unit.map({calendar.dateByAddingUnit(.Day, value: -$0, toDate: today, options: [])}).filter({$0 != nil}).map({formatter.stringFromDate($0!)})
    }
    
    class func todayString() -> String {
        let today = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = self.API_FORMAT
        return formatter.stringFromDate(today)
    }
}

class GankNetworkUtil {
    
    static let API_DATA_URL = "http://gank.avosapps.com/api/data/%E7%A6%8F%E5%88%A9/"
    static let API_DAY_URL  = "http://gank.avosapps.com/api/day/"
    static let API_RANDOM_URL = "http://gank.avosapps.com/api/day/2015/10/10"
    
    static let PAGE_SIZE = 20
    
    class func getGanks(page: Int, complete: (SGCellsEntiy, ErrorType?) -> Void) {
        
        let url = "\(API_DATA_URL)\(PAGE_SIZE)/\(page)"
        if (DEBUG) {
            print(url)
        }
        Pitaya.build(HTTPMethod: .GET, url: url).onNetworkError({ (error) -> Void in
            
            complete(SGCellsEntiy(JSONNDObject: JSONND.initWithData(NSData.init())), NSError.init(domain: "请求失败!", code: 9999, userInfo: nil))
            
        }).responseJSON({ (json, response) -> Void in
            
            let j = SGCellsEntiy(JSONNDObject: json)
            guard j.error == false && j.results.count != 0 else {
                complete(SGCellsEntiy(JSONNDObject: JSONND.initWithData(NSData.init())), NSError.init(domain: "请求失败!", code: 9999, userInfo: nil))
                return
            }
            complete(j, nil)
        })
    }
    
    class func getTodayGank(complete: (SGShowEntiy, ErrorType?) -> Void) {
        
        if (DEBUG) {
            print(API_DAY_URL + GankDateUtil.todayString())
        }
        Pitaya.build(HTTPMethod: .GET, url: API_DAY_URL + GankDateUtil.todayString()).onNetworkError({ (error) -> Void in
            
            getRandomGank(complete)
            
        }).responseJSON({ (json, response) -> Void in
            
            let j = SGShowEntiy(JSONNDObject: json)
            guard j.error == false && j.category.count != 0 else {
                getRandomGank(complete)
                return
            }
            complete(j,nil)
        })
    }
    
    class func getDateGank(date: String, complete: (SGShowEntiy, ErrorType?) -> Void) {
        if (DEBUG) {
            print(API_DAY_URL + date)
        }
        Pitaya.build(HTTPMethod: .GET, url: API_DAY_URL + date).onNetworkError({ (error) -> Void in
            
            getRandomGank(complete)
            
        }).responseJSON({ (json, response) -> Void in
            
            let j = SGShowEntiy(JSONNDObject: json)
            guard j.error == false && j.category.count != 0 else {
                getRandomGank(complete)
                return
            }
            complete(j,nil)
        })
    }
    
    class func getRandomGank(complete: (SGShowEntiy, ErrorType?) -> Void) {
        
        let url = "\(API_RANDOM_URL)"
        if (DEBUG) {
            print("Random URL --> \(url)")
        }
        Pitaya.build(HTTPMethod: .GET, url: url).onNetworkError ({ (error) -> Void in
            
            complete(SGShowEntiy(JSONNDObject: JSONND.initWithData(NSData.init())), error)
            
        }).responseJSON ({ (json, response) -> Void in
            
            let j = SGShowEntiy(JSONNDObject: json)
            guard j.error == false && j.category.count != 0 else {
                
                complete(SGShowEntiy(JSONNDObject: JSONND.initWithData(NSData.init())), NSError.init(domain: "请求失败!", code: 9999, userInfo: nil))
                return
            }
            complete(j,nil)
        })
    }
}