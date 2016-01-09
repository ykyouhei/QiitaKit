//
//  PostItem.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 ユーザからの投稿を表します
 */
public struct PostItem: Mappable {
    
    /// タグを特定するための一意な名前
    private(set) var id: String!
    
    /// HTML形式の本文
    private(set) var renderedBody: String!
    
    /// Markdown形式の本文
    private(set) var body: String!
    
    /// この投稿が共同更新状態かどうか (Qiita:Teamでのみ有効)
    private(set) var coediting: Bool!
    
    /// データが作成された日時
    private(set) var createdAt: NSDate!
    
    /// 限定共有状態かどうかを表すフラグ (Qiita:Teamでは無効)
    private(set) var privated: Bool!
    
    /// このタグが付けられた投稿の数
    private(set) var tags: [[String : AnyObject]]!
    
    /// 投稿のタイトル
    private(set) var title: String!
    
    /// データが最後に更新された日時
    private(set) var updatedAt: NSDate!
    
    /// 投稿のURL
    private(set) var URL: NSURL!
    
    /// 投稿者
    private(set) var user: User!
    
    
    public init?(_ map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        id              <- map["id"]
        renderedBody    <- map["rendered_body"]
        body            <- map["body"]
        coediting       <- map["coediting"]
        createdAt       <- (map["created_at"], qiitaDateTransform())
        privated        <- map["private"]
        tags            <- map["tags"]
        title           <- map["title"]
        updatedAt       <- (map["updated_at"], qiitaDateTransform())
        URL             <- (map["url"], URLTransform())
        user            <- map["user"]
    }
    
}