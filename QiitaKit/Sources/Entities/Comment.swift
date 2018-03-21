//
//  Comment.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation


/// 投稿に付けられたコメントを表します
///
/// https://qiita.com/api/v2/docs#コメント
public struct Comment: Codable, CustomStringConvertible, QiitaResponse {
    
    /// コメントの内容を表すMarkdown形式の文字列
    public let body: String
    
    /// データが作成された日時
    public let createdAt: Date
    
    /// コメントの一意なID
    public let id: String
    
    /// コメントの内容を表すHTML形式の文字列
    public let renderedBody: String
    
    /// データが最後に更新された日時
    public let updatedAt: Date
    
    /// Qiita上のユーザを表します
    public let user: User
    
}

extension Comment {
    
    enum CodingKeys: String, CodingKey {
        case body         = "body"
        case createdAt    = "created_at"
        case id           = "id"
        case renderedBody = "rendered_body"
        case updatedAt    = "updated_at"
        case user         = "user"
    }
    
}
