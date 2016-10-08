//
//  PatchCommentRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit


public extension QiitaAPI.Comment {
    
    /**
     コメントを更新します
     
     https://qiita.com/api/v2/docs#patch-apiv2commentscomment_id
     */
    public struct PatchCommentRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// 更新するコメントID
        public let commentID: String
        
        /// コメントの内容を表すMarkdown形式の文字列
        public let body: String
        
        
        // MARK: Initialize
        
        public init(commentID: String, body: String) {
            self.commentID = commentID
            self.body      = body
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .patch
        }
        
        public var path: String {
            return "comments/\(commentID)"
        }
        
        public var parameters: Any? {
            return [
                "body" : body
            ]
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Comment {
            return Comment(json: JSON(object))
        }
        
    }
    
}
