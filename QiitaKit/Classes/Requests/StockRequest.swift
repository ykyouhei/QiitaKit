//
//  StockRequest.swift
//  QiitaKit
//
//  Created by 山口　恭兵 on 2016/01/11.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import APIKit

/**
 現在のアクセストークンで認証中のユーザを取得するリクエスト
 */
public struct StockRequest {
    
    public let itemID: String
    
    public let method: HTTPMethod
    
    public init(itemID: String, method: HTTPMethod) {
        self.itemID = itemID
        self.method = method
    }
    
}

extension StockRequest: QiitaRequestType {
    
    public var path: String {
        return "/items/\(itemID)/stock"
    }
    
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Bool? {
        return URLResponse.statusCode == 204
    }
    
}
