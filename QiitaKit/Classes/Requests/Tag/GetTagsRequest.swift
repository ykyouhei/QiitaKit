//
//  GetTagsRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

public extension QiitaAPI.Tag {
    
    /**
     タグ一覧を作成日時の降順で返します
     
     https://qiita.com/api/v2/docs#get-apiv2tags
     */
    public struct GetTagsRequest: QiitaPageableRequestType {
        
        /**
         並び順
         
         - Count: 投稿数順
         - Name:  名前順
         */
        public enum Sort: String {
            case Count = "count"
            case Name  = "name"
        }
        
        // MARK: Properties
        
        /// ページ番号 (1から100まで)
        public var page: Int
        
        /// 1ページあたりに含まれる要素数 (1から100まで)
        public var perPage: Int
       
        /// 並び順
        public let sort: Sort
        
        
        // MARK: Initialize
        
        public init(page: Int, perPage: Int, sort: Sort) {
            self.page    = page
            self.perPage = perPage
            self.sort    = sort
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .GET
        }
        
        public var path: String {
            return "tags"
        }
        
        public var queryParameters: [String : AnyObject]? {
            var params = pageParamaters
            params["sort"] = sort.rawValue
            return params
        }
        
        public func responseFromObjects(object: AnyObject) throws -> [Tag] {
            guard let json = object as? [[String: AnyObject]] else { throw QiitaKitError.InvalidJSON }
            return try Unbox(json)
        }
        
    }
    
}
