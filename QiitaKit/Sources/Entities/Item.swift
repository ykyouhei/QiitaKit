//
//  PostItem.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation

/// ユーザからの投稿を表します
public struct Item: Codable, CustomStringConvertible, QiitaResponse {
    
    public struct Tag: Codable {
        let name: String
        let versions: [String]
    }
    
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
    public let tags: [Item.Tag]
    
    /// 投稿のタイトル
    public let title: String
    
    /// データが最後に更新された日時
    public let updatedAt: Date
    
    /// 投稿のURL
    public let URL: Foundation.URL
    
    /// 投稿者
    public let user: User
    
}

extension Item {
    
    enum CodingKeys: String, CodingKey {
        case id           = "id"
        case renderedBody = "rendered_body"
        case body         = "body"
        case coediting    = "coediting"
        case createdAt    = "created_at"
        case group        = "group"
        case privated     = "private"
        case tags         = "tags"
        case title        = "title"
        case updatedAt    = "updated_at"
        case URL          = "url"
        case user         = "user"
    }
    
}
