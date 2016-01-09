//
//  Tag.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 投稿に付けられた個々のタグを表します
 */
public struct Tag  {
    
    /// タグを特定するための一意な名前
    public private(set) var id: String!
    
    /// このタグをフォローしているユーザの数
    public private(set) var followersCount: Int!
    
    /// このタグが付けられた投稿の数
    public private(set) var itemsCount : Int!
    
    /// このタグに設定されたアイコン画像のURL
    public private(set) var iconURL: NSURL?
    
}

extension Tag: Mappable {
    
    public init?(_ map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        id              <- map["id"]
        followersCount  <- map["followers_count"]
        itemsCount      <- map["items_count"]
        iconURL         <- (map["icon_url"], URLTransform())
    }
    
}
