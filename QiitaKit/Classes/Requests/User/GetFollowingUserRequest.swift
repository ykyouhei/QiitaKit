//
//  GetFollowingRequest.swift
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
     ユーザをフォローしているか確認します
     
     https://qiita.com/api/v2/docs#get-apiv2usersuser_idfollowing
     */
    public struct GetFollowingRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// フォローを確認するユーザID
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
            return "users/\(userID)/following"
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> User {
            guard let json = object as? [String: Any] else {
                throw QiitaKitError.invalidJSON
            }
            return try Unbox(dictionary: json)
        }
        
    }
    
}
