//
//  DeleteThankRequest.swift
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
     コメントからThankを外します
     
     https://qiita.com/api/v2/docs#delete-apiv2commentscomment_idthank
     */
    public struct DeleteThankRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// Thankを外すコメントID
        public let commentID: String
        
        
        // MARK: Initialize
        
        public init(commentID: String) {
            self.commentID = commentID
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .delete
        }
        
        public var path: String {
            return "comments/\(commentID)/thank"
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Comment {
            guard let json = object as? [String: Any] else {
                throw QiitaKitError.invalidJSON
            }
            return try Unbox(dictionary: json)
        }
        
    }
    
}
