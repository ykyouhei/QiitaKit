//
//  GetTagsRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Tag {
    
    /// 並び順
    ///
    /// - count: 投稿数順
    /// - name:  名前順
    public enum Sort: String {
        case count = "count"
        case name  = "name"
    }
    
    /// タグ一覧を作成日時の降順で返します
    ///
    /// https://qiita.com/api/v2/docs#get-apiv2tags
    public struct GetTagsRequest: QiitaPageableRequestType {
        
        public typealias Response = PageableResponse<Tag>

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
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "tags"
        }
        
        public var queries: [String: String]? {
            var params = pageParamaters
            params["sort"] = sort.rawValue
            return params
        }
        
    }
    
}
