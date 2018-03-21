//
//  PostCommentRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Comment {
    
    /// 投稿に対してコメントを投稿します
    ///
    /// https://qiita.com/api/v2/docs#post-apiv2itemsitem_idcomments
    public struct PostCommentRequest: QiitaRequest {
        
        public typealias Response = Comment
        
        // MARK: Properties
        
        /// 投稿ID
        public let itemID: String
        
        /// コメントの内容を表すMarkdown形式の文字列
        public let body: String
        
        
        // MARK: Initialize
        
        public init(itemID: String, body: String) {
            self.itemID = itemID
            self.body   = body
        }
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .post
        }
        
        public var path: String {
            return "items/\(itemID)/comments"
        }
        
        public var bodyParames: [String: Any]? {
            return [
                "body" : body
            ]
        }
        
    }
    
}
