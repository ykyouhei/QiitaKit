//
//  TagTests.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import XCTest
import Unbox
@testable import QiitaKit

class TagTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParse() {
        let json = readJSON("Tag", forClass: type(of: self))
        let tag: Tag = try! Unbox(data: json)
        
        XCTAssertEqual(100, tag.followersCount)
        XCTAssertEqual("https://s3-ap-northeast-1.amazonaws.com/qiita-tag-image/9de6a11d330f5694820082438f88ccf4a1b289b2/medium.jpg", tag.iconURL?.absoluteString)
        XCTAssertEqual("qiita", tag.id)
        XCTAssertEqual(200, tag.itemsCount)
        
    }
    
}
