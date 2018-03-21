//
//  GetFollowingRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Tag {
    
    /// タグをフォローしているかどうかを調べます
    ///
    /// https://qiita.com/api/v2/docs#get-apiv2tagstag_idfollowing
    public struct GetFollowingRequest: QiitaRequest {
        
        public typealias Response = Tag
        
        // MARK: Properties
        
        /// フォローしているかどうかを調べるタグID
        public let tagID: String
        
        
        // MARK: Initialize
        
        public init(tagID: String) {
            self.tagID = tagID
        }
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "tags/\(tagID)/following"
        }
        
    }
    
}
