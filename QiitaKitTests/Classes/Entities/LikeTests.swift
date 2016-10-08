//
//  LikeTests.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import XCTest

@testable import QiitaKit

class LikeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParse() {
        let json = readJSON("Like", forClass: type(of: self))
        let like = Like(data: json)
        XCTAssertEqual(Date(timeIntervalSince1970: 946684800), like.createdAt)
        XCTAssertEqual("Hiroshige Umino", like.user.name)
    }
    
}
