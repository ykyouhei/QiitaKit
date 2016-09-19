//
//  Like.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import Unbox

/**
 投稿に付けられた個々のタグを表します
 
 https://qiita.com/api/v2/docs#いいね
 */
public struct Like: CustomStringConvertible {
    
    /// データが作成された日時
    public let createdAt: Date
    
    /// Qiita上のユーザを表します
    public let user: User
    
}

extension Like: Unboxable {
    
    public init(unboxer: Unboxer) {
        createdAt = unboxer.unbox(key: "created_at", formatter: ISO8601DateFormatter)
        user      = unboxer.unbox(key: "user")
    }
    
}
