//
//  GetAuthenticatedUserRequest.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.User {

    /// 現在のアクセストークンで認証中のユーザを取得するリクエスト
    ///
    /// https://qiita.com/api/v2/docs#get-apiv2authenticated_user
    public struct GetAuthenticatedUserRequest: QiitaRequest {

        public typealias Response = AuthenticatedUser

        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/authenticated_user"
        }
        
        public init() {
        }

    }

}

