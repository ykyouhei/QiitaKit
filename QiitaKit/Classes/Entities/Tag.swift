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
public struct Tag: CustomStringConvertible {
    
    /// タグを特定するための一意な名前
    public let id: String
    
    /// このタグをフォローしているユーザの数
    public let followersCount: Int
    
    /// このタグが付けられた投稿の数
    public let itemsCount: Int
    
    /// このタグに設定されたアイコン画像のURL
    public let iconURL: URL?
    
}

extension Tag: Unboxable {
    
    public init(unboxer: Unboxer) {
        id             = unboxer.unbox(key: "id")
        followersCount = unboxer.unbox(key: "followers_count")
        itemsCount     = unboxer.unbox(key: "items_count")
        iconURL        = unboxer.unbox(key: "icon_url")
    }
    
}
