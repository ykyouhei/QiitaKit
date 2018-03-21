//
//  DeleteItemRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Item {
    
    /// 投稿を削除します
    ///
    /// https://qiita.com/api/v2/docs#delete-apiv2itemsitem_id
    public struct DeleteItemRequest: QiitaRequest {
        
        public typealias Response = Item
        
        // MARK: Properties
        
        /// 削除する投稿ID
        public let itemID: String
        
        
        // MARK: Initialize
        
        public init(itemID: String) {
            self.itemID = itemID
        }
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .delete
        }
        
        public var path: String {
            return "items/\(itemID)"
        }
        
    }
    
}
