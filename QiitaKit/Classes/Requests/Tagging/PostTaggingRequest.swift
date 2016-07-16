//
//  PostTaggingRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

public extension QiitaAPI.Tagging {
    
    /**
     投稿にタグを追加します。Qiita:Teamでのみ有効です
     
     https://qiita.com/api/v2/docs#post-apiv2itemsitem_idtagging
     */
    public struct PostTaggingRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// 投稿ID
        public let itemID: String
        
        /// タグを特定するための一意な名前
        public let name: String
        
        /// versions
        public let versions: [String]
        
        
        // MARK: Initialize
        
        public init(itemID: String, name: String, versions: [String]) {
            self.itemID   = itemID
            self.name     = name
            self.versions = versions
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .POST
        }
        
        public var path: String {
            return "items/\(itemID)/taggings"
        }
        
        public var parameters: AnyObject? {
            return [
                "name"     : name,
                "versions" : versions
            ]
        }
        
        public func responseFromObject(object: AnyObject,
                                       URLResponse: NSHTTPURLResponse) throws -> Tagging {
            guard let json = object as? [String: AnyObject] else { throw QiitaKitError.InvalidJSON }
            return try Unbox(json)
        }
        
    }
    
}
