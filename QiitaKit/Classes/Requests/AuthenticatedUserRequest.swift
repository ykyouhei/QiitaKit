//
//  AuthenticatedUserRequest.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import ObjectMapper

/**
 現在のアクセストークンで認証中のユーザを取得するリクエスト
 */
public struct AuthenticatedUserRequest {
    
    public init() {
    }
    
}

extension AuthenticatedUserRequest: QiitaRequestType {
    
    public var method: HTTPMethod {
        return .GET
    }
    
    public var path: String {
        return "/authenticated_user"
    }
    
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> AuthenticatedUser? {
        return Mapper<AuthenticatedUser>().map(object)
    }
    
}
