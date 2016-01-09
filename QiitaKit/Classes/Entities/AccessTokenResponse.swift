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
public struct AccessTokenResponse {
    
    public private(set) var clientID: String!
    
    public private(set) var token: String!
   
}

extension AccessTokenResponse: Mappable {
   
    public init?(_ map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        clientID <- map["client_id"]
        token    <- map["token"]
    }
     
}

