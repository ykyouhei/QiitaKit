//
//  AccessTokenResponseTests.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import XCTest

@testable import QiitaKit

class AccessTokenResponseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParse() {
        let json = readJSON("AccessTokenResponse", forClass: type(of: self))
        let accessToken = try! jsonDecoder().decode(AccessToken.self, from: json)

        XCTAssertEqual("a91f0396a0968ff593eafdd194e3d17d32c41b1da7b25e873b42e9058058cd9d", accessToken.clientID)
        XCTAssertEqual("ea5d0a593b2655e9568f144fb1826342292f5c6b7d406fda00577b8d1530d8a5", accessToken.token)
    }
    
}
