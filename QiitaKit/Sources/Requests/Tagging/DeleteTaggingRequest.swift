//
//  DeleteTaggingRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Tagging {
    
    /// 投稿から指定されたタグを取り除きます。Qiita:Teamでのみ有効です
    ///
    /// https://qiita.com/api/v2/docs#delete-apiv2itemsitem_idtaggingstagging_id
    public struct DeleteTaggingRequest: QiitaRequest {
        
        public typealias Response = EmptyResponse
        
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
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .delete
        }
        
        public var path: String {
            return "items/\(itemID)/taggings/\(taggingID)"
        }
        
    }
    
}
