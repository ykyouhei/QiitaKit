//
//  PutStockRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Item {
    
    /// 投稿をストックします
    ///
    /// https://qiita.com/api/v2/docs#put-apiv2itemsitem_idstock
    public struct PutStockRequest: QiitaRequest {
        
        public typealias Response = EmptyResponse
        
        // MARK: Properties
        
        /// 投稿ID
        public let itemID: String
        
        
        // MARK: Initialize
        
        public init(itemID: String) {
            self.itemID = itemID
        }
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .put
        }
        
        public var path: String {
            return "items/\(itemID)/stock"
        }
        
    }
    
}
