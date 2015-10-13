//
//  SGBaseEntiy.swift
//  SoGank
//
//  Created by ule_shengyangyu on 15/10/10.
//  Copyright © 2015年 ule_shengyangyu. All rights reserved.
//

import Foundation
import Pitaya

class SGBaseEntiy: JSONNDModel {
    var who = ""
    var publishedAt = ""
    var desc = ""
    var type = ""
    var url = ""
    var used = ""
    var objectId = ""
    var createdAt = ""
    var updatedAt = ""
}

class SGResultsEntiy: JSONNDModel {
    
    //福利 | Android | iOS | 休息视频 | 拓展资源 | 前端 | 瞎推荐
    var 福利 = [SGBaseEntiy]()
    var Android = [SGBaseEntiy]()
    var iOS = [SGBaseEntiy]()
    var 休息视频 = [SGBaseEntiy]()
    var 拓展资源 = [SGBaseEntiy]()
    var 前端 = [SGBaseEntiy]()
    var 瞎推荐 = [SGBaseEntiy]()
    
    required init(JSONNDObject json: JSONND) {
        super.init(JSONNDObject: json)
        
        for j in json["福利"].arrayValue {
            self.福利.append(SGBaseEntiy(JSONNDObject: j))
        }
        for j in json["Android"].arrayValue {
            self.Android.append(SGBaseEntiy(JSONNDObject: j))
        }
        for j in json["iOS"].arrayValue {
            self.iOS.append(SGBaseEntiy(JSONNDObject: j))
        }
        for j in json["休息视频"].arrayValue {
            self.休息视频.append(SGBaseEntiy(JSONNDObject: j))
        }
        for j in json["拓展资源"].arrayValue {
            self.拓展资源.append(SGBaseEntiy(JSONNDObject: j))
        }
        for j in json["前端"].arrayValue {
            self.前端.append(SGBaseEntiy(JSONNDObject: j))
        }
        for j in json["瞎推荐"].arrayValue {
            self.瞎推荐.append(SGBaseEntiy(JSONNDObject: j))
        }
    }
}

class SGShowEntiy: JSONNDModel {
    var error = true
    var results : SGResultsEntiy!
    var category = [String]()
    
    required init(JSONNDObject json: JSONND) {
        super.init(JSONNDObject: json)
        
        for j in json["category"].arrayValue {
            self.category.append(j.stringValue)
        }
        self.results = SGResultsEntiy(JSONNDObject: json["results"])
    }
}

class SGCellsEntiy: JSONNDModel {
    var error = true
    var results = [SGBaseEntiy]()
    
    required init(JSONNDObject json: JSONND) {
        super.init(JSONNDObject: json)
        
        for j in json["results"].arrayValue {
            self.results.append(SGBaseEntiy(JSONNDObject: j))
        }
    }
}