//
//  GroupTests.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import XCTest
import Unbox
@testable import QiitaKit

class GroupTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParse() {
        let json = readJSON("Group", forClass: self.dynamicType)
        let group: Group = try! Unbox(json)
    
        XCTAssertEqual(NSDate(timeIntervalSince1970: 946684800), group.createdAt)
        XCTAssertEqual(1, group.id)
        XCTAssertEqual("Dev", group.name)
        XCTAssertEqual(false, group.privated)
        XCTAssertEqual(NSDate(timeIntervalSince1970: 946684800), group.updatedAt)
        XCTAssertEqual("dev", group.urlName)
    }
    
}
