//
//  DeleteThankRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Comment {
    
    /// コメントからThankを外します
    ///
    /// https://qiita.com/api/v2/docs#delete-apiv2commentscomment_idthank
    public struct DeleteThankRequest: QiitaRequest {

        public typealias Response = Comment
        
        // MARK: Properties
        
        /// Thankを外すコメントID
        public let commentID: String
        
        
        // MARK: Initialize
        
        public init(commentID: String) {
            self.commentID = commentID
        }
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .delete
        }
        
        public var path: String {
            return "comments/\(commentID)/thank"
        }
        
    }
    
}
