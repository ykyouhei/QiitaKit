//
//  GroupTests.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import XCTest

@testable import QiitaKit

class GroupTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParse() {
        let json = readJSON("Group", forClass: type(of: self))
        let group = try! jsonDecoder().decode(Group.self, from: json)
    
        XCTAssertEqual(Date(timeIntervalSince1970: 946684800), group.createdAt)
        XCTAssertEqual(1, group.id)
        XCTAssertEqual("Dev", group.name)
        XCTAssertEqual(false, group.privated)
        XCTAssertEqual(Date(timeIntervalSince1970: 946684800), group.updatedAt)
        XCTAssertEqual("dev", group.urlName)
    }
    
}
