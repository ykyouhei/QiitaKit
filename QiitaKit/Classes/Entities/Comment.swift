//
//  Comment.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import Unbox

/**
 投稿に付けられたコメントを表します

 https://qiita.com/api/v2/docs#コメント
 */
public struct Comment {
    
    /// コメントの内容を表すMarkdown形式の文字列
    public let body: String
    
    /// データが作成された日時
    public let createdAt: NSDate
    
    /// コメントの一意なID
    public let id: String
    
    /// コメントの内容を表すHTML形式の文字列
    public let renderedBody: String
    
    /// データが最後に更新された日時
    public let updatedAt: NSDate
    
    /// Qiita上のユーザを表します
    public let user: User
    
}

extension Comment: Unboxable {
    
    public init(unboxer: Unboxer) {
        body         = unboxer.unbox("body")
        createdAt    = unboxer.unbox("created_at", formatter: ISO8601DateFormatter)
        id           = unboxer.unbox("id")
        renderedBody = unboxer.unbox("rendered_body")
        updatedAt    = unboxer.unbox("updated_at", formatter: ISO8601DateFormatter)
        user         = unboxer.unbox("user")
    }
    
}
