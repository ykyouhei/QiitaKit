//
//  QiitaRequestType.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit


public protocol QiitaRequestType: Request {}


extension QiitaRequestType {
    
    var version: String {
        return "v2"
    }
    
    public var baseURL: URL {
        let domain = AuthManager.sharedManager.teamDomain ?? "qiita.com"
        return URL(string: "https://\(domain)/api/\(version)")!
    }
    
    public var headerFields: [String : String] {
        guard let token = AuthManager.sharedManager.accessToken else {
            return [String : String]()
        }
        return [
            "Authorization" : "Bearer \(token)"
        ]
    }
    
    public func intercept(object: Any, URLResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(URLResponse.statusCode) else {
            throw QiitaKitError(object: object)
        }
        
        return object
    }
    
}

/**
 ページ可能なリクエスト用のレスポンスオブジェクト
 */
public struct PageableResponse<Element> {
    
    public let totalCount: Int
    
    public let currentPage: Int
    
    public let objects: [Element]
    
    public let nextPage: Int?
    
    public let prevPage: Int?
    
    public var count: Int {
        return objects.count
    }
    
    public var hasNext: Bool {
        return nextPage != nil
    }
    
    public var hasPrev: Bool {
        return prevPage != nil
    }
    
    public init() {
        self.init(totalCount: 0, currentPage: 0, objects: [], nextPage: nil, prevPage: nil)
    }
    
    internal init(totalCount: Int, currentPage: Int, objects: [Element], nextPage: Int?, prevPage: Int?) {
        self.totalCount  = totalCount
        self.currentPage = currentPage
        self.nextPage    = nextPage
        self.prevPage    = prevPage
        self.objects     = objects
    }
    
    public subscript(index: Int) -> Element {
        return objects[index]
    }
    
}

/**
 ページ可能なリクエストのプロトコル
 */
public protocol QiitaPageableRequestType: QiitaRequestType {
    
    associatedtype Element
    
    
    /// ページ番号 (1から100まで)
    var page: Int { get set }
    
    /// 1ページあたりに含まれる要素数 (1から100まで)
    var perPage: Int { get set }
    
    /**
     HTTPレスポンスをパースする
     
     - parameter object: レスポンスオブジェクト
     
     - returns: [Element]
     */
    func response(from object: Any) throws -> [Element]
    
}

public extension QiitaPageableRequestType {
    
    typealias Response = PageableResponse<Element>
    
    /// ページング用パラメータ
    var pageParamaters: [String : String] {
        return [
            "page"     : "\(page)",
            "per_page" : "\(perPage)"
        ]
    }
    
    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> PageableResponse<Element> {
        let elements       = try response(from: object)
        let currentPage    = self.page
        var totalCount     = Int(0)
        var nextPage: Int? = nil
        var prevPage: Int? = nil

        if let count = urlResponse.allHeaderFields["Total-Count"] as? String {
            totalCount = Int(count) ?? 0
        }
        
        if let link = urlResponse.allHeaderFields["Link"] as? String {
            if link.contains("rel=\"prev\"") {
                prevPage = currentPage - 1
            }
            if link.contains("rel=\"next\"") {
                nextPage = currentPage + 1
            }
        }
        
        return PageableResponse(
            totalCount: totalCount,
            currentPage: currentPage,
            objects: elements,
            nextPage: nextPage,
            prevPage: prevPage
        )
    }
    
}

