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
    case ReadQiita      = "read_qiita"
    case ReadQiitaTeam  = "read_qiita_team"
    case WriteQiita     = "write_qiita"
    case WriteQiitaTeam = "write_qiita_team"
}

/**
 アプリケーションのユーザに認可画面を表示するためのリクエスト
 */
public struct AuthorizeRequest {
    
    /// 登録されたAPIクライアントを特定するためのIDです。40桁の16進数で表現されます。
    let clientID: String
    
    /// アプリケーションが利用するスコープ
    let scopes: Set<Scope>
    
    /// CSRF対策のため、認可後にリダイレクトするURLのクエリに含まれる値
    let state: String
    
}

extension AuthorizeRequest: QiitaRequestType {
    
    public typealias Response = AnyObject
    
    public var method: HTTPMethod {
        return .GET
    }
    
    public var path: String {
        return "/oauth/authorize"
    }
    
    public var parameters: [String : AnyObject] {
        return [
            "client_id" : clientID,
            "scope"     : scopes.map{ $0.rawValue }.joinWithSeparator(" "),
            "state"     : state
        ]
    }
    
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        return nil
    }
    
}
