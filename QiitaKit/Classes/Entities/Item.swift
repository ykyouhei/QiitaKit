//
//  PostItem.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation


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
    public let tags: [[String : Any]]
    
    /// 投稿のタイトル
    public let title: String
    
    /// データが最後に更新された日時
    public let updatedAt: Date
    
    /// 投稿のURL
    public let URL: Foundation.URL
    
    /// 投稿者
    public let user: User
    
}

extension Item: JSONParsable {
    
    internal init(json: JSON) {
        id           = json["id"].string!
        renderedBody = json["rendered_body"].string!
        body         = json["body"].string!
        coediting    = json["coediting"].bool!
        createdAt    = json["created_at"].date!
        group        = json["group"].dictionary.map { Group(json: JSON($0)) }
        privated     = json["private"].bool!
        tags         = json["tags"].object as! [[String : Any]]
        title        = json["title"].string!
        updatedAt    = json["updated_at"].date!
        URL          = json["url"].url!
        user         = User(json: json["user"])
    }
    
}
