//
//  StockRequest.swift
//  QiitaKit
//
//  Created by 山口　恭兵 on 2016/01/11.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit

extension QiitaAPI {
    
    /**
     現在のアクセストークンで認証中のユーザを取得するリクエスト
     */
    public struct StockRequest: QiitaRequestType {
        
        public let itemID: String
        
        public let method: HTTPMethod
        
        public init(itemID: String, method: HTTPMethod) {
            self.itemID = itemID
            self.method = method
        }
        
        
        // MARK: QiitaRequestType
        
        public var path: String {
            return "/items/\(itemID)/stock"
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Bool {
            return URLResponse.statusCode == 204
        }
        
    }
    
}
