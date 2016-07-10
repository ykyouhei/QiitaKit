//
//  AuthenticatedUserTests.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import XCTest
import Unbox
@testable import QiitaKit

class AuthenticatedUserTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testParse() {
        let json = readJSON("AuthenticatedUser", forClass: self.dynamicType)
        let authenticatedUser: AuthenticatedUser = try! Unbox(json)
        
        XCTAssertEqual("Hello, world.", authenticatedUser.description)
        XCTAssertEqual("yaotti", authenticatedUser.facebookID)
        XCTAssertEqual(100, authenticatedUser.followeesCount)
        XCTAssertEqual(200, authenticatedUser.followersCount)
        XCTAssertEqual("yaotti", authenticatedUser.githubLoginName)
        XCTAssertEqual("yaotti", authenticatedUser.id)
        XCTAssertEqual(300, authenticatedUser.itemsCount)
        XCTAssertEqual("yaotti", authenticatedUser.linkedinID)
        XCTAssertEqual("Tokyo, Japan", authenticatedUser.location)
        XCTAssertEqual("Hiroshige Umino", authenticatedUser.name)
        XCTAssertEqual("Increments Inc", authenticatedUser.organization)
        XCTAssertEqual(1, authenticatedUser.permanentID)
        XCTAssertEqual("https://si0.twimg.com/profile_images/2309761038/1ijg13pfs0dg84sk2y0h_normal.jpeg", authenticatedUser.profileImageURL.absoluteString)
        XCTAssertEqual("yaotti", authenticatedUser.twitterScreenName)
        XCTAssertEqual("http://yaotti.hatenablog.com", authenticatedUser.websiteURL?.absoluteString)
        XCTAssertEqual(1048576, authenticatedUser.imageMonthlyUploadLimit)
        XCTAssertEqual(524288, authenticatedUser.imageMonthlyUploadRemaining)
        XCTAssertEqual(false, authenticatedUser.teamOnly)
    }

}
