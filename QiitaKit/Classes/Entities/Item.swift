//
//  PostItem.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import Unbox

/**
 ユーザからの投稿を表します
 */
public struct Item: CustomStringConvertible {
    
    /// タグを特定するための一意な名前
    public let id: String
    
    /// HTML形式の本文
    public let renderedBody: String
    
    /// Markdown形式の本文
    public let body: String
    
    /// この投稿が共同更新状態かどうか (Qiita:Teamでのみ有効)
    public let coediting: Bool
    
    /// データが作成された日時
    public let createdAt: Date
    
    /// Qiita:Teamのグループを表します
    public let group: Group?
    
    /// 限定共有状態かどうかを表すフラグ (Qiita:Teamでは無効)
    public let privated: Bool
    
    /// このタグが付けられた投稿の数
    public let tags: [[String : AnyObject]]
    
    /// 投稿のタイトル
    public let title: String
    
    /// データが最後に更新された日時
    public let updatedAt: Date
    
    /// 投稿のURL
    public let URL: Foundation.URL
    
    /// 投稿者
    public let user: User
    
}

extension Item: Unboxable {
    
    public init(unboxer: Unboxer) {
        id           = unboxer.unbox(key: "id")
        renderedBody = unboxer.unbox(key: "rendered_body")
        body         = unboxer.unbox(key: "body")
        coediting    = unboxer.unbox(key: "coediting")
        createdAt    = unboxer.unbox(key: "created_at", formatter: ISO8601DateFormatter)
        group        = unboxer.unbox(key: "group")
        privated     = unboxer.unbox(key: "private")
        tags         = unboxer.unbox(key: "tags")
        title        = unboxer.unbox(key: "title")
        updatedAt    = unboxer.unbox(key: "updated_at", formatter: ISO8601DateFormatter)
        URL          = unboxer.unbox(key: "url")
        user         = unboxer.unbox(key: "user")
    }
    
}
