//
//  DeleteFollowingRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.User {
    
    /// ユーザのフォローを外します
    ///
    /// https://qiita.com/api/v2/docs#delete-apiv2usersuser_idfollowing
    public struct DeleteFollowingRequest: QiitaRequest {
        
        public typealias Response = EmptyResponse
        
        // MARK: Properties
        
        /// フォローを外すユーザID
        public let userID: String
        
        
        // MARK: Initialize
        
        public init(userID: String) {
            self.userID = userID
        }
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .delete
        }
        
        public var path: String {
            return "users/\(userID)/following"
        }
        
    }
    
}
