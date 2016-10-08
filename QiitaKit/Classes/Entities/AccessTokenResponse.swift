//
//  AccessTokenResponse.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation

/**
 アクセストークン情報
 */
public struct AccessTokenResponse: CustomStringConvertible {
    
    public let clientID: String
    
    public let token: String
   
}

extension AccessTokenResponse: JSONParsable {
   
    internal init(json: JSON) {
        self.clientID = json["client_id"].string!
        self.token    = json["token"].string!
    }
    
}

