//
//  GetTagRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

public extension QiitaAPI.Tag {
    
    /**
     タグを取得します
     
     https://qiita.com/api/v2/docs#get-apiv2tagstag_id
     */
    public struct GetTagRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// 取得するタグID
        public let tagID: String
        
        
        // MARK: Initialize
        
        public init(tagID: String) {
            self.tagID = tagID
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "tags/\(tagID)"
        }
        
        public func response(from object: Any,
                             urlResponse: HTTPURLResponse) throws -> Tag {
            guard let json = object as? [String: AnyObject] else {
                throw QiitaKitError.invalidJSON
            }
            return try Unbox(dictionary: json)
        }
        
    }
    
}
