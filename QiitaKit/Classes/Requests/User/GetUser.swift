//
//  GetUser.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit


public extension QiitaAPI.User {
    
    /**
     ユーザを取得します
     
     https://qiita.com/api/v2/docs#get-apiv2usersuser_id
     */
    public struct GetUserRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// 取得するユーザID
        public let userID: String
        
        
        // MARK: Initialize
        
        public init(userID: String) {
            self.userID = userID
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "users/\(userID)"
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> User {
            return User(json: JSON(object))
        }
        
    }
    
}
