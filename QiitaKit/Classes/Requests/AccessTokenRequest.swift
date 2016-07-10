//
//  AccessTokenRequest.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

extension QiitaAPI {
    
    /**
     与えられた認証情報をもとに新しいアクセストークンを発行します
     
     https://qiita.com/api/v2/docs#post-apiv2access_tokens
     */
    public struct AccessTokenRequest: QiitaRequestType {
        
        /// 登録されたAPIクライアントを特定するためのID
        let clientID: String
        
        /// 登録されたAPIクライアントを認証するための秘密鍵
        let clientSecret: String
        
        /// リダイレクト用のURLに付与された、アクセストークンと交換するための文字列
        let code: String
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .POST
        }
        
        public var path: String {
            return "/access_tokens"
        }
        
        public var parameters: AnyObject? {
            return [
                "client_id"     : clientID,
                "client_secret" : clientSecret,
                "code"          : code
            ]
        }
        
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> AccessTokenResponse {
            guard let json = object as? [String: AnyObject] else { throw QiitaKitError.InvalidJSON }
            return try Unbox(json)
        }
        
    }
    
}
