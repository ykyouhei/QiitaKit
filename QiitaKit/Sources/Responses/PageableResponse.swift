//
//  PageableResponse.swift
//  QiitaKit
//
//  Created by kyohei yamaguchi on 2018/03/21.
//  Copyright © 2018年 kyo__hei. All rights reserved.
//

import Foundation

/// ページ可能なリクエスト用のレスポンスオブジェクト
public struct PageableResponse<Element: Decodable>: QiitaResponse {
    
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
        self.totalCount = 0
        self.currentPage = 1
        self.objects = []
        self.nextPage = nil
        self.prevPage = nil
    }
    
    public init(response: HTTPURLResponse, json: Data) throws {
        func pageNum(with target: String) -> Int? {
            let link = response.allHeaderFields["Link"] as! String
            let range =  NSRange(location: 0, length: link.count)
            let pattern = "<.+[\\?|&]page=([0-9]+)[^>]*>; rel=\"\(target)\""

            guard let matched = try! NSRegularExpression(pattern: pattern).firstMatch(in: link, options: [], range: range) else {
                return nil
            }
            
            return Int(NSString(string: link).substring(with: matched.range(at: 1)))
        }

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        self.objects = try jsonDecoder.decode(Array<Element>.self, from: json)
        self.totalCount = Int(response.allHeaderFields["total-count"] as! String)!
        self.prevPage = pageNum(with: "prev")
        self.nextPage = pageNum(with: "next")
        
        switch (self.prevPage, self.nextPage) {
        case let (.some(prev), _):          self.currentPage = prev + 1
        case let (_, .some(next)):          self.currentPage = next - 1
        default:                            self.currentPage = 1
        }
    }
    
    public subscript(index: Int) -> Element {
        return objects[index]
    }
    
}
