//
//  QiitaRequest.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

/// QiitaAPIリクエスト用のプロトコル
public protocol QiitaRequest {
    
    associatedtype Response: QiitaResponse
    
    /// HTTPMethod
    var method: HTTPMethod { get }

    /// APIパス
    var path: String { get }
    
    /// URLクエリ。optional
    var queries: [String: String]? { get }
    
    /// HTTPBody。optional
    var bodyParames: [String: Any]? { get }

}

extension QiitaRequest {
    
    /// APIバージョン
    var version: String {
        return "v2"
    }
    
    /// APIホスト
    public var baseURL: URL {
        let domain = AuthManager.sharedManager.teamDomain ?? "qiita.com"
        return URL(string: "https://\(domain)/api/\(version)")!
    }
    
    /// HTTPHeader
    public var headerFields: [String : String] {
        var result = ["Content-Type": "application/json"]
        
        guard let token = AuthManager.sharedManager.accessToken else {
            return result
        }
        
        result["Authorization"] = "Bearer \(token)"
        
        return result
    }
    
    public var queries: [String: String]? {
        return nil
    }
    
    public var bodyParames: [String: Any]? {
        return nil
    }
    
    public func asURLRequest() -> URLRequest {
        let url: URL = {
            var componets = URLComponents()
            componets.scheme = "https"
            componets.host = AuthManager.sharedManager.teamDomain ?? "qiita.com"
            componets.path = "/api/\(version)/\(path)"
            componets.queryItems = queries?.map { URLQueryItem(name: $0.key, value: $0.value) }
            return componets.url!
        }()
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        request.allHTTPHeaderFields = headerFields
        request.httpBody = bodyParames.map { try! JSONSerialization.data(withJSONObject: $0, options: []) }
        request.httpMethod = method.rawValue
        
        return request
    }
    
}


/// ページ可能なリクエストのプロトコル
public protocol QiitaPageableRequestType: QiitaRequest {
    
    /// ページ番号 (1から100まで)
    var page: Int { get set }
    
    /// 1ページあたりに含まれる要素数 (1から100まで)
    var perPage: Int { get set }
    
}

public extension QiitaPageableRequestType {
    
    /// ページング用パラメータ
    var pageParamaters: [String: String] {
        return [
            "page"     : "\(page)",
            "per_page" : "\(perPage)"
        ]
    }
    
}

