//
//  AuthorizeRequest.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit

/**
 APIのスコープ
 
 - ReadQiita:      Qiitaからアクセストークンに紐付いたユーザに関連したデータを読み出す
 - ReadQiitaTeam:  Qiita:Teamからデータを読み出す
 - WriteQiita:     Qiitaにデータを書き込む
 - WriteQiitaTeam: Qiita:Teamにデータを書き込む
 */
public enum Scope: String {
    case readQiita      = "read_qiita"
    case readQiitaTeam  = "read_qiita_team"
    case writeQiita     = "write_qiita"
    case writeQiitaTeam = "write_qiita_team"
}

public extension QiitaAPI.Authorization {

    /**
     アプリケーションのユーザに認可画面を表示するためのリクエスト
     */
    public struct AuthorizeRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// 登録されたAPIクライアントを特定するためのIDです。40桁の16進数で表現されます。
        let clientID: String
        
        /// アプリケーションが利用するスコープ
        let scopes: Set<Scope>
        
        /// CSRF対策のため、認可後にリダイレクトするURLのクエリに含まれる値
        let state: String
        
        
        // MARK: Initialize
        
        public init(clientID: String, scopes: Set<Scope>, state: String) {
            self.clientID = clientID
            self.scopes   = scopes
            self.state    = state
        }
        
    
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/oauth/authorize"
        }
        
        public var parameters: Any? {
            return [
                "client_id" : clientID,
                "scope"     : scopes.map{ $0.rawValue }.joined(separator: " "),
                "state"     : state
            ]
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Bool {
            return true
        }
        
    }
    
}
