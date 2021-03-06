//
//  GetCommentRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Comment {
    
    /// コメントを取得します
    ///
    /// https://qiita.com/api/v2/docs#get-apiv2commentscomment_id
    public struct GetCommentRequest: QiitaRequest {
        
        public typealias Response = Comment
        
        // MARK: Properties
        
        /// 取得するコメントID
        public let commentID: String
        
        
        // MARK: Initialize
        
        public init(commentID: String) {
            self.commentID = commentID
        }
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "comments/\(commentID)"
        }
        
    }
    
}
