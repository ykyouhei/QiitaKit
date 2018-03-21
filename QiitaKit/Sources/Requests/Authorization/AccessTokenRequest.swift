//
//  AccessTokenRequest.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Authorization {
    
    /// 与えられた認証情報をもとに新しいアクセストークンを発行します
    ///
    /// https://qiita.com/api/v2/docs#post-apiv2access_tokens
    public struct AccessTokenRequest: QiitaRequest {

        // MARK: Types
        
        public typealias Response = AccessToken
        
        
        // MARK: Properties
        
        /// 登録されたAPIクライアントを特定するためのID
        let clientID: String
        
        /// 登録されたAPIクライアントを認証するための秘密鍵
        let clientSecret: String
        
        /// リダイレクト用のURLに付与された、アクセストークンと交換するための文字列
        let code: String
        
        
        // MARK: Initialize
        
        public init(clientID: String, clientSecret: String, code: String) {
            self.clientID     = clientID
            self.clientSecret = clientSecret
            self.code         = code
        }
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .post
        }
        
        public var path: String {
            return "access_tokens"
        }

        public var bodyParames: [String: Any]? {
            return [
                "client_id"     : clientID,
                "client_secret" : clientSecret,
                "code"          : code
            ]
        }
        
    }
    
}
