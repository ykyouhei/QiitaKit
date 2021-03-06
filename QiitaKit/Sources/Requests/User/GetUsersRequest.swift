//
//  GetUsersRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.User {
    
    /// 全てのユーザの一覧を作成日時の降順で取得します
    ///
    /// https://qiita.com/api/v2/docs#get-apiv2users
    public struct GetUsersRequest: QiitaPageableRequestType {
        
        public typealias Response = PageableResponse<User>

        // MARK: Properties
        
        /// ページ番号 (1から100まで)
        public var page: Int
        
        /// 1ページあたりに含まれる要素数 (1から100まで)
        public var perPage: Int
        
        
        // MARK: Initialize
        
        public init(page: Int, perPage: Int) {
            self.page    = page
            self.perPage = perPage
        }
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "users"
        }
        
        public var queries: [String: String]? {
            return pageParamaters
        }
        
    }
    
}
