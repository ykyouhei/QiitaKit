//
//  GetStockersRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit


public extension QiitaAPI.User {
    
    /**
     投稿をストックしているユーザ一覧を、ストックした日時の降順で返します
     
     https://qiita.com/api/v2/docs#get-apiv2itemsitem_idstockers
     */
    public struct GetStockersRequest: QiitaPageableRequestType {
        
        // MARK: Properties
        
        /// 投稿ID
        public let itemID: String
        
        /// ページ番号 (1から100まで)
        public var page: Int
        
        /// 1ページあたりに含まれる要素数 (1から100まで)
        public var perPage: Int
        
        
        // MARK: Initialize
        
        public init(itemID: String, page: Int, perPage: Int) {
            self.page    = page
            self.perPage = perPage
            self.itemID  = itemID
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "items/\(itemID)/stockers"
        }
        
        public var queryParameters: [String : Any]? {
            return pageParamaters as [String : Any]?
        }
        
        public func response(from object: Any) throws -> [User] {
            guard let json = object as? [Any] else {
                throw QiitaKitError.invalidJSON
            }
            return json.map{ User(json: JSON($0)) }
        }
        
    }
    
}
