//
//  QiitaRequestType.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit


public protocol QiitaRequestType: RequestType {}


extension QiitaRequestType {
    
    var version: String {
        return "v2"
    }
    
    public var baseURL: NSURL {
        let domain = AuthManager.sharedManager.teamDomain ?? "qiita.com"
        return NSURL(string: "https://\(domain)/api/\(version)")!
    }
    
    public var headerFields: [String : String] {
        guard let token = AuthManager.sharedManager.accessToken else {
            return [String : String]()
        }
        return [
            "Authorization" : "Bearer \(token)"
        ]
    }
    
    public func interceptObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> AnyObject {
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
    func responseFromObjects(object: AnyObject) throws -> [Element]
    
}

public extension QiitaPageableRequestType {
    
    /// ページング用パラメータ
    var pageParamaters: [String : String] {
        return [
            "page"     : "\(page)",
            "per_page" : "\(perPage)"
        ]
    }
    
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> PageableResponse<Element> {
        let elements       = try responseFromObjects(object)
        let currentPage    = self.page
        var totalCount     = Int(0)
        var nextPage: Int? = nil
        var prevPage: Int? = nil

        if let count = URLResponse.allHeaderFields["Total-Count"]?.integerValue {
            totalCount = count
        }
        
        if let link = URLResponse.allHeaderFields["Link"] as? String {
            if link.containsString("rel=\"prev\"") {
                prevPage = currentPage - 1
            }
            if link.containsString("rel=\"next\"") {
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

