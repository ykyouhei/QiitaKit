//
//  PutFollowingRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit


public extension QiitaAPI.Tag {
    
    /**
     タグをフォローします
     
     https://qiita.com/api/v2/docs#get-apiv2tagstag_idfollowing
     */
    public struct PutFollowingRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// フォローするタグID
        public let tagID: String
        
        
        // MARK: Initialize
        
        public init(tagID: String) {
            self.tagID = tagID
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .put
        }
        
        public var path: String {
            return "tags/\(tagID)/following"
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Bool {
            return urlResponse.statusCode == 204
        }
        
    }
    
}
