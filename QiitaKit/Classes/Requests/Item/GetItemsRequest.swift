//
//  ItemsRequest.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

public extension QiitaAPI.Item {
    
    // MARK: Types
    
    /**
     取得する投稿のタイプ
     
     - Query:               クエリにマッチする投稿一覧
     - Tag:                 指定されたタグが付けられた投稿一覧
     - AuthenticatedUser:   認証中のユーザの投稿一覧
     - UserPosted:          指定されたユーザの投稿一覧
     - UserStocks:          指定されたユーザがストックした投稿一覧
     */
    public enum ItemsType {
        case query(query: String)
        case tag(tagID: String)
        case authenticatedUser
        case userPosted(userID: String)
        case userStocks(userID: String)
    }
    
    /**
     投稿の一覧を作成日時の降順で返します
     
     https://qiita.com/api/v2/docs#get-apiv2items
     */
    public struct GetItemsRequest: QiitaPageableRequestType {
        
        // MARK: Properties
        
        /// 取得する投稿のタイプ
        public let type: ItemsType
        
        /// ページ番号 (1から100まで)
        public var page: Int
        
        /// 1ページあたりに含まれる要素数 (1から100まで)
        public var perPage: Int
        
        
        // MARK: Initialize
       
        public init(type: ItemsType, page: Int, perPage: Int) {
            self.type    = type
            self.page    = page
            self.perPage = perPage
        }
        
        
        // MARK: QiitaPageableRequestType
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            switch type {
            case .query:                    return "items"
            case .tag(let tagID):           return "tags/\(tagID)/items"
            case .authenticatedUser:        return "authenticated_user/items"
            case .userPosted(let userID):   return "users/\(userID)/items"
            case .userStocks(let userID):   return "users/\(userID)/stocks"
            }
        }
        
        public var queryParameters: [String : AnyObject]? {
            var params = pageParamaters
            if case .query(let query) = type {
                params["query"] = query
            }
            return params as [String : AnyObject]?
        }
    
        public func response(from object: Any) throws -> [Item] {
            guard let json = object as? [[String: AnyObject]] else {
                throw QiitaKitError.invalidJSON
            }
            return try Unbox(dictionaries: json)
        }
        
    }
    
}
