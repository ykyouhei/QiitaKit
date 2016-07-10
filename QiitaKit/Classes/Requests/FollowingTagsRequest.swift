//
//  FollowingTagsRequest.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

extension QiitaAPI {

    /**
     ユーザがフォローしているタグ一覧をフォロー日時の降順で返すリクエスト
     */
    public struct FollowingTagsRequest: QiitaPageableRequestType {
        
        /// 取得するユーザのID
        public let userID: String
        
        /// ページ番号 (1から100まで)
        public var page: Int
        
        /// 1ページあたりに含まれる要素数 (1から100まで)
        public var perPage: Int
        
        
        public init(userID: String, page: Int = 1, perPage: Int = 20) {
            self.userID  = userID
            self.page    = page
            self.perPage = perPage
        }
        
        
        // MARK: QiitaPageableRequestType
    
        public var method: HTTPMethod {
            return .GET
        }
        
        public var path: String {
            return "users/\(userID)/following_tags"
        }
        
        public var parameters: AnyObject? {
            return pageParamaters
        }
        
        public func responseFromObjects(object: AnyObject) throws -> [Tag] {
            guard let json = object as? [[String: AnyObject]] else { throw QiitaKitError.InvalidJSON }
            return try Unbox(json)
        }
        
    }
    
}
