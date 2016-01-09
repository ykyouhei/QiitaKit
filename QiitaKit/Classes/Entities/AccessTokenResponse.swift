//
//  AccessTokenResponse.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 アクセストークン情報
 */
public struct AccessTokenResponse: Mappable {
    
    private(set) var clientID: String!
    
    private(set) var token: String!
    
    public init?(_ map: Map) {
    }
    
    // Mappable
    public mutating func mapping(map: Map) {
        clientID <- map["client_id"]
        token    <- map["token"]
    }
    
}
