//
//  PutThankRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit


public extension QiitaAPI.Comment {
    
    /**
     コメントにThankを付けます
     
     https://qiita.com/api/v2/docs#put-apiv2commentscomment_idthank
     */
    public struct PutThankRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// Thankを付けるコメントID
        public let commentID: String
        
        
        // MARK: Initialize
        
        public init(commentID: String) {
            self.commentID = commentID
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .put
        }
        
        public var path: String {
            return "comments/\(commentID)/thank"
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Comment {
            return Comment(json: JSON(object))
        }
        
    }
    
}
