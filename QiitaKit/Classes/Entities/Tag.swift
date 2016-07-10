//
//  Tag.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import Unbox

/**
 投稿に付けられた個々のタグを表します
 */
public struct Tag  {
    
    /// タグを特定するための一意な名前
    public let id: String
    
    /// このタグをフォローしているユーザの数
    public let followersCount: Int
    
    /// このタグが付けられた投稿の数
    public let itemsCount: Int
    
    /// このタグに設定されたアイコン画像のURL
    public let iconURL: NSURL?
    
}

extension Tag: Unboxable {
    
    public init(unboxer: Unboxer) {
        id             = unboxer.unbox("id")
        followersCount = unboxer.unbox("followers_count")
        itemsCount     = unboxer.unbox("items_count")
        iconURL        = unboxer.unbox("icon_url")
    }
    
}
