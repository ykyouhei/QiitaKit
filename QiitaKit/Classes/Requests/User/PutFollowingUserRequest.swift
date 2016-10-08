//
//  PutFollowingRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit


public extension QiitaAPI.User {
    
    /**
     ユーザをフォローします
     
     https://qiita.com/api/v2/docs#put-apiv2usersuser_idfollowing
     */
    public struct PutFollowingRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// フォローするユーザID
        public let userID: String
        
        
        // MARK: Initialize
        
        public init(userID: String) {
            self.userID = userID
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .put
        }
        
        public var path: String {
            return "users/\(userID)/following"
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Bool {
            return urlResponse.statusCode == 204
        }
        
    }
    
}
