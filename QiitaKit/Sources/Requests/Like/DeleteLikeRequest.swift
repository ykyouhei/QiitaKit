//
//  DeleteLikeRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Like {
    
    /// 投稿への「いいね！」を取り消します。Qiita:Teamでのみ有効です
    ///
    /// https://qiita.com/api/v2/docs#delete-apiv2itemsitem_idlike
    public struct DeleteLikesRequest: QiitaRequest {
        
        public typealias Response = EmptyResponse
        
        // MARK: Properties
        
        /// 投稿のID
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
            return "items/\(itemID)/like"
        }
        
    }
    
}
