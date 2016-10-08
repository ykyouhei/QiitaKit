//
//  GetFollowingTagsRequest.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit


public extension QiitaAPI.Tag {

    /**
     ユーザがフォローしているタグ一覧をフォロー日時の降順で返します
     
     https://qiita.com/api/v2/docs#get-apiv2usersuser_idfollowing_tags
     */
    public struct GetFollowingTagsRequest: QiitaPageableRequestType {
        
        // MARK: Propeties
        
        /// 取得するユーザのID
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
        
        
        // MARK: QiitaPageableRequestType
    
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "users/\(userID)/following_tags"
        }
        
        public var parameters: Any? {
            return pageParamaters as Any?
        }
        
        public func response(from object: Any) throws -> [Tag] {
            guard let json = object as? [Any] else {
                throw QiitaKitError.invalidJSON
            }
            return json.map{ Tag(json: JSON($0)) }
        }
        
    }
    
}
