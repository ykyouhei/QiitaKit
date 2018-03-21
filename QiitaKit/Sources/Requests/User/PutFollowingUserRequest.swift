//
//  PutFollowingRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.User {
    
    /// ユーザをフォローします
    ///
    /// https://qiita.com/api/v2/docs#put-apiv2usersuser_idfollowing
    public struct PutFollowingRequest: QiitaRequest {
        
        public typealias Response = EmptyResponse
        
        
        // MARK: Properties
        
        /// フォローするユーザID
        public let userID: String
        
        
        // MARK: Initialize
        
        public init(userID: String) {
            self.userID = userID
        }
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .put
        }
        
        public var path: String {
            return "users/\(userID)/following"
        }
        
    }
    
}
