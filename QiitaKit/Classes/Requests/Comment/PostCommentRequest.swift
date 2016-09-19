//
//  PostCommentRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

public extension QiitaAPI.Comment {
    
    /**
     投稿に対してコメントを投稿します
     
     https://qiita.com/api/v2/docs#post-apiv2itemsitem_idcomments
     */
    public struct PostCommentRequest: QiitaRequestType {
        
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
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .post
        }
        
        public var path: String {
            return "items/\(itemID)/comments"
        }
        
        public var parameters: Any? {
            return [
                "body" : body
            ]
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Comment {
            guard let json = object as? [String: AnyObject] else {
                throw QiitaKitError.invalidJSON
            }
            return try Unbox(dictionary: json)
        }
        
    }
    
}
