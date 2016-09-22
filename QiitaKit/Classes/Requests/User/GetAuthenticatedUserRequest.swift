//
//  GetAuthenticatedUserRequest.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

public extension QiitaAPI.User {

    /**
     現在のアクセストークンで認証中のユーザを取得するリクエスト
     
     https://qiita.com/api/v2/docs#get-apiv2authenticated_user
     */
    public struct GetAuthenticatedUserRequest: QiitaRequestType {
        
        public init() {
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/authenticated_user"
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> AuthenticatedUser {
            guard let json = object as? [String: Any] else {
                throw QiitaKitError.invalidJSON
            }
            return try Unbox(dictionary: json)
        }
        
    }

}

