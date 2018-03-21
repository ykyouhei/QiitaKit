//
//  AccessToken.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation

/// アクセストークン情報
public struct AccessToken: Codable, CustomStringConvertible, QiitaResponse {
    
    public let clientID: String
    
    public let token: String
    
}

extension AccessToken {
   
    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case token    = "token"
    }
    
}

