//
//  AccessTokenResponse.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import Unbox

/**
 アクセストークン情報
 */
public struct AccessTokenResponse {
    
    public let clientID: String
    
    public let token: String
   
}

extension AccessTokenResponse: Unboxable {
   
    public init(unboxer: Unboxer) {
        self.clientID = unboxer.unbox("client_id")
        self.token    = unboxer.unbox("token")
    }
    
}

