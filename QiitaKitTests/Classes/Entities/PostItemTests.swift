//
//  PostItemTests.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import XCTest

@testable import QiitaKit

class PostItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParse() {
        let json = readJSON("PostItem", forClass: type(of: self))
        let postItem = Item(data: json)
        
        XCTAssertEqual("<h1>Example</h1>", postItem.renderedBody)
        XCTAssertEqual("# Example", postItem.body)
        XCTAssertEqual(false, postItem.coediting)
        XCTAssertEqual(Date(timeIntervalSince1970: 946684800), postItem.createdAt)
        XCTAssertNotNil(postItem.group)
        XCTAssertEqual("4bd431809afb1bb99e4f", postItem.id)
        XCTAssertEqual(false, postItem.privated)
        XCTAssertEqual(1, postItem.tags.count)
        XCTAssertEqual("Example title", postItem.title)
        XCTAssertEqual(Date(timeIntervalSince1970: 946684800), postItem.updatedAt)
        XCTAssertEqual("https://qiita.com/yaotti/items/4bd431809afb1bb99e4f", postItem.URL.absoluteString)
        XCTAssertNotNil(postItem.user)
    }
    
}
