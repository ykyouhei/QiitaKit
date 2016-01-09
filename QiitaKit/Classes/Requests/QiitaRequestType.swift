//
//  QiitaRequestType.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import KeychainAccess

public protocol QiitaRequestType: RequestType {
}

extension QiitaRequestType {
    
    var version: String {
        return "v2"
    }
    
    public var baseURL: NSURL {
        let domain = AuthManager.teamDomain ?? "qiita.com"
        return NSURL(string: "https://\(domain)/api/\(version)")!
    }
    
    public var HTTPHeaderFields: [String : String] {
        guard let token = AuthManager.accessToken else {
            return [String : String]()
        }
        return [
            "Authorization" : "Bearer \(token)"
        ]
    }
    
    public func errorFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> ErrorType? {
        guard let json = object as? [String : String],
            type = json["type"],
            message = json["message"] else
        {
            return nil
        }
        return QiitaKitError.CommonError(message: message, type: type)
    }

}

/**
 ページ可能なリクエスト用のレスポンスオブジェクト
 */
public struct PageableResponse<Element> {
    
    public let totalCount: Int
    
    public let currentPage: Int
    
    public let objects: [Element]
    
    public let hasNext: Bool
    
    public let hasPrev: Bool
    
    public var count: Int {
        return objects.count
    }
    
    public init() {
        self.totalCount = 0
        self.currentPage = 0
        self.hasNext = false
        self.hasPrev = false
        self.objects = [Element]()
    }
    
    internal init(totalCount: Int, currentPage: Int, hasNext: Bool, hasPrev: Bool, objects: [Element]) {
        self.totalCount = totalCount
        self.currentPage = currentPage
        self.hasNext = hasNext
        self.hasPrev = hasPrev
        self.objects = objects
    }
    
    public subscript(index: Int) -> Element {
        return objects[index]
    }
    
}

/**
 ページ可能なリクエストのプロトコル
 */
public protocol QiitaPageableRequestType: QiitaRequestType {
    
    typealias Element
    
    /// ページ番号 (1から100まで)
    var page: Int { get set }
    
    /// 1ページあたりに含まれる要素数 (1から100まで)
    var perPage: Int { get set }
    
    /**
     HTTPレスポンスをパースする
     
     - parameter object: レスポンスオブジェクト
     
     - returns: [Element]
     */
    func responseFromObjects(object: AnyObject) -> [Element]?
    
}

public extension QiitaPageableRequestType {
    
    /// ページング用パラメータ
    var pageParamaters: [String : String] {
        return [
            "page"     : "\(page)",
            "per_page" : "\(perPage)"
        ]
    }
    
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> PageableResponse<Element>? {
        guard let elements = responseFromObjects(object) else {
            return nil
        }
        
        let totalCount = (URLResponse.allHeaderFields["Total-Count"] as? Int) ?? 0
        var hasNext = false
        var hasPrev = false
        
        if let link = URLResponse.allHeaderFields["Link"] as? String {
            hasPrev = link.containsString("rel=\"prev\"")
            hasNext = link.containsString("rel=\"next\"")
            
//            if link.containsString("rel=\"prev\"") {
//                prevRequest = self
//                prevRequest!.page -= 1
//            }
//            if link.containsString("rel=\"next\"") {
//                nextRequest = self
//                nextRequest!.page += 1
//            }
        }
        
        return PageableResponse(
            totalCount: totalCount,
            currentPage: self.page,
            hasNext: hasNext,
            hasPrev: hasPrev,
            objects: elements
        )
    }
    
}

