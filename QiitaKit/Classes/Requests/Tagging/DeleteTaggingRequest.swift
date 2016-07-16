//
//  DeleteTaggingRequest.swift
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
     投稿から指定されたタグを取り除きます。Qiita:Teamでのみ有効です
     
     https://qiita.com/api/v2/docs#delete-apiv2itemsitem_idtaggingstagging_id
     */
    public struct DeleteTaggingRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// 投稿ID
        public let itemID: String
        
        /// 削除するTaggingID
        public let taggingID: String
        
        
        // MARK: Initialize
        
        public init(itemID: String, taggingID: String) {
            self.itemID    = itemID
            self.taggingID = taggingID
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .DELETE
        }
        
        public var path: String {
            return "items/\(itemID)/taggings/\(taggingID)"
        }
        
        public func responseFromObject(object: AnyObject,
                                       URLResponse: NSHTTPURLResponse) throws -> Bool {
            return URLResponse.statusCode == 204
        }
        
    }
    
}
