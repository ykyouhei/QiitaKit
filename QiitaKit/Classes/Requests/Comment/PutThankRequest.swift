//
//  PutThankRequest.swift
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
            return .PUT
        }
        
        public var path: String {
            return "comments/\(commentID)/thank"
        }
        
        public func responseFromObject(object: AnyObject,
                                       URLResponse: NSHTTPURLResponse) throws -> Comment {
            guard let json = object as? [String: AnyObject] else { throw QiitaKitError.InvalidJSON }
            return try Unbox(json)
        }
        
    }
    
}