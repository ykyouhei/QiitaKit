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
    
    /**
     投稿の一覧を作成日時の降順で返します
     
     https://qiita.com/api/v2/docs#get-apiv2items
     */
    public struct GetItemsRequest: QiitaPageableRequestType {
        
        // MARK: Types
        
        /**
         取得する投稿のタイプ
         
         - Query:               クエリにマッチする投稿一覧
         - Tag:                 指定されたタグが付けられた投稿一覧
         - AuthenticatedUser:   認証中のユーザの投稿一覧
         - UserPosted:          指定されたユーザの投稿一覧
         - UserStocks:          指定されたユーザがストックした投稿一覧
         */
        public enum Type {
            case Query(query: String)
            case Tag(tagID: String)
            case AuthenticatedUser
            case UserPosted(userID: String)
            case UserStocks(userID: String)
        }
        
        // MARK: Properties
        
        /// 取得する投稿のタイプ
        public let type: Type
        
        /// ページ番号 (1から100まで)
        public let page: Int
        
        /// 1ページあたりに含まれる要素数 (1から100まで)
        public let perPage: Int
        
        
        // MARK: Initialize
       
        public init(type: Type, page: Int, perPage: Int) {
            self.type    = type
            self.page    = page
            self.perPage = perPage
        }
        
        
        // MARK: QiitaPageableRequestType
        
        public var method: HTTPMethod {
            return .GET
        }
        
        public var path: String {
            switch type {
            case .Query:                    return "items"
            case .Tag(let tagID):           return "tags/\(tagID)/items"
            case .AuthenticatedUser:        return "authenticated_user/items"
            case .UserPosted(let userID):   return "users/\(userID)/items"
            case .UserStocks(let userID):   return "users/\(userID)/stocks"
            }
        }
        
        public var queryParameters: [String : AnyObject]? {
            var params = pageParamaters
            if case .Query(let query) = type {
                params["query"] = query
            }
            return params
        }
    
        public func responseFromObjects(object: AnyObject) throws -> [Item] {
            guard let json = object as? [[String: AnyObject]] else { throw QiitaKitError.InvalidJSON }
            return try Unbox(json)
        }
        
    }
    
}
