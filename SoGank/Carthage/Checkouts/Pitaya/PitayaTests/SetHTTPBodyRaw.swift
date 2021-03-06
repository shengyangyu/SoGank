//
//  SetHTTPBodyRaw.swift
//  Pitaya
//
//  Created by 吕文翰 on 15/10/11.
//  Copyright © 2015年 http://lvwenhan.com. All rights reserved.
//

import XCTest
import Pitaya
import JSONNeverDie

class SetHTTPBodyRawTests: BaseTestCase {
    
    func testSetHTTPBodyRawString() {
        let expectation = expectationWithDescription("testSetHTTPBodyRawString")
        let rawString = self.randomStringWithLength(20)
        Pita.build(HTTPMethod: .POST, url: "http://httpbin.org/post")
            .setHTTPBodyRaw(rawString)
            .onNetworkError({ (error) -> Void in
                XCTAssert(false, error.localizedDescription)
            })
            .responseJSON { (json, response) -> Void in
                XCTAssertEqual(json["data"].stringValue, rawString)
                expectation.fulfill()
        }
        waitForExpectationsWithTimeout(self.defaultTimeout, handler: nil)
    }
    
    func testSetHTTPBodyRawJSON() {
        let expectation = expectationWithDescription("testSetHTTPBodyRawString")
        
        let string1 = self.randomStringWithLength(20)
        let string2 = self.randomStringWithLength(20)
        let j: JSONND = ["string1": string1, "string2": string2]

        Pita.build(HTTPMethod: .POST, url: "http://httpbin.org/post")
            .setHTTPBodyRaw(j.jsonStringValue)
            .onNetworkError({ (error) -> Void in
                XCTAssert(false, error.localizedDescription)
            })
            .responseJSON { (json, response) -> Void in
                XCTAssertEqual(json["data"].stringValue, j.jsonStringValue)
                XCTAssertEqual(json["json"]["string1"].stringValue, string1)
                XCTAssertEqual(json["json"]["string2"].stringValue, string2)
                expectation.fulfill()
        }
        waitForExpectationsWithTimeout(self.defaultTimeout, handler: nil)
    }
}