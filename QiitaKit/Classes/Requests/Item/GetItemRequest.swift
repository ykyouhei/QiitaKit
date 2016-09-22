//
//  GetItemRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

public extension QiitaAPI.Item {
    
    /**
     投稿を取得します
     
     https://qiita.com/api/v2/docs#get-apiv2itemsitem_id
     */
    public struct GetItemRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// 取得する投稿ID
        public let itemID: String
        
        
        // MARK: Initialize
        
        public init(itemID: String) {
            self.itemID = itemID
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "items/\(itemID)"
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Item {
            guard let json = object as? [String: Any] else {
                throw QiitaKitError.invalidJSON
            }
            return try Unbox(dictionary: json)
        }
        
    }
    
}
