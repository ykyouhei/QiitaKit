//
//  PutLikeRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit


public extension QiitaAPI.Like {
    
    /**
     投稿に「いいね！」を付けます。Qiita:Teamでのみ有効です
     
     https://qiita.com/api/v2/docs#put-apiv2itemsitem_idlike
     */
    public struct PutLikesRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// 投稿のID
        public let itemID: String
        
        
        // MARK: Initialize
        
        public init(itemID: String) {
            self.itemID = itemID
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .put
        }
        
        public var path: String {
            return "items/\(itemID)/like"
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Bool {
            return urlResponse.statusCode == 204
        }
        
    }
    
}
