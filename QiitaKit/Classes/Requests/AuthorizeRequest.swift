//
//  AuthorizeRequest.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit

public struct AuthorizeRequest {
    
    /* ====================================================================== */
    // MARK: - Types
    /* ====================================================================== */
    
    /**
    APIのスコープ
    
    - ReadQiita:      Qiitaからアクセストークンに紐付いたユーザに関連したデータを読み出す
    - ReadQiitaTeam:  Qiita:Teamからデータを読み出す
    - WriteQiita:     Qiitaにデータを書き込む
    - WriteQiitaTeam: Qiita:Teamにデータを書き込む
    */
    struct Scope: OptionSetType {
        let rawValue: Int
        
        static let ReadQiita      = Scope(rawValue: 0)
        static let ReadQiitaTeam  = Scope(rawValue: 1 << 0)
        static let WriteQiita     = Scope(rawValue: 1 << 1)
        static let WriteQiitaTeam = Scope(rawValue: 1 << 2)
        
        var paramaterString: String {
            var scopes = [String]()
            
            if contains(.ReadQiita) {
                scopes.append("read_qiita")
            }
            if contains(.ReadQiitaTeam) {
                scopes.append("read_qiita_team")
            }
            if contains(.WriteQiita) {
                scopes.append("write_qiita")
            }
            if contains(.WriteQiitaTeam) {
                scopes.append("write_qiita_team")
            }
            
            return scopes.joinWithSeparator(" ")
        }
    }
    
    
    /* ====================================================================== */
    // MARK: - Properties
    /* ====================================================================== */
    
    /// QiitaAPIのClientID
    let clientID: String
    
    /// 利用許可を求めるスコープ
    let scope: Scope
    
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
            "scope" : scope.paramaterString,
            "state" : state
        ]
    }
    
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        return nil
    }
}
