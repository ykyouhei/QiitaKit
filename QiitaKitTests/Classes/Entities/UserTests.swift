//
//  UserTests.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import XCTest

@testable import QiitaKit

class UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParse() {
        let json = readJSON("User", forClass: type(of: self))
        let user = User(data: json)
        
        XCTAssertEqual("Hello, world.", user.userDescription)
        XCTAssertEqual("yaotti", user.facebookID)
        XCTAssertEqual(100, user.followeesCount)
        XCTAssertEqual(200, user.followersCount)
        XCTAssertEqual("yaotti", user.githubLoginName)
        XCTAssertEqual("yaotti", user.id)
        XCTAssertEqual(300, user.itemsCount)
        XCTAssertEqual("yaotti", user.linkedinID)
        XCTAssertEqual("Tokyo, Japan", user.location)
        XCTAssertEqual("Hiroshige Umino", user.name)
        XCTAssertEqual("Increments Inc", user.organization)
        XCTAssertEqual(1, user.permanentID)
        XCTAssertEqual("https://si0.twimg.com/profile_images/2309761038/1ijg13pfs0dg84sk2y0h_normal.jpeg", user.profileImageURL.absoluteString)
        XCTAssertEqual("yaotti", user.twitterScreenName)
        XCTAssertEqual("http://yaotti.hatenablog.com", user.websiteURL?.absoluteString)
    }
    
}
