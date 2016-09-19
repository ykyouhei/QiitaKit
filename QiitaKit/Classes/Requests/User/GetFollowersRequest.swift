//
//  GetFollowersRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

public extension QiitaAPI.User {
    
    /**
     ユーザをフォローしているユーザ一覧を取得します
     
     https://qiita.com/api/v2/docs#get-apiv2usersuser_idfollowers
     */
    public struct GetFollowersRequest: QiitaPageableRequestType {
        
        // MARK: Properties
        
        /// 取得するユーザID
        public let userID: String
        
        /// ページ番号 (1から100まで)
        public var page: Int
        
        /// 1ページあたりに含まれる要素数 (1から100まで)
        public var perPage: Int
        
        
        // MARK: Initialize
        
        public init(userID: String, page: Int, perPage: Int) {
            self.userID  = userID
            self.page    = page
            self.perPage = perPage
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "users/\(userID)/followers"
        }
        
        public var queryParameters: [String : AnyObject]? {
            return pageParamaters as [String : AnyObject]?
        }
        
        public func response(from object: Any) throws -> [User] {
            guard let json = object as? [[String: AnyObject]] else {
                throw QiitaKitError.invalidJSON
            }
            return try Unbox(dictionaries: json)
        }
        
    }
    
}
