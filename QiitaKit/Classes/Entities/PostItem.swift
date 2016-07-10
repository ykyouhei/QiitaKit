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
public struct PostItem {
    
    /// タグを特定するための一意な名前
    public let id: String
    
    /// HTML形式の本文
    public let renderedBody: String
    
    /// Markdown形式の本文
    public let body: String
    
    /// この投稿が共同更新状態かどうか (Qiita:Teamでのみ有効)
    public let coediting: Bool
    
    /// データが作成された日時
    public let createdAt: NSDate
    
    /// Qiita:Teamのグループを表します
    public let group: Group?
    
    /// 限定共有状態かどうかを表すフラグ (Qiita:Teamでは無効)
    public let privated: Bool
    
    /// このタグが付けられた投稿の数
    public let tags: [[String : AnyObject]]
    
    /// 投稿のタイトル
    public let title: String
    
    /// データが最後に更新された日時
    public let updatedAt: NSDate
    
    /// 投稿のURL
    public let URL: NSURL
    
    /// 投稿者
    public let user: User
    
}

extension PostItem: Unboxable {
    
    public init(unboxer: Unboxer) {
        id           = unboxer.unbox("id")
        renderedBody = unboxer.unbox("rendered_body")
        body         = unboxer.unbox("body")
        coediting    = unboxer.unbox("coediting")
        createdAt    = unboxer.unbox("created_at", formatter: ISO8601DateFormatter)
        group        = unboxer.unbox("group")
        privated     = unboxer.unbox("private")
        tags         = unboxer.unbox("tags")
        title        = unboxer.unbox("title")
        updatedAt    = unboxer.unbox("updated_at", formatter: ISO8601DateFormatter)
        URL          = unboxer.unbox("url")
        user         = unboxer.unbox("user")
    }
    
}
