//
//  QiitaResponse.swift
//  QiitaKit
//
//  Created by kyohei yamaguchi on 2018/03/21.
//  Copyright © 2018年 kyo__hei. All rights reserved.
//

import Foundation

/// QiitaAPIレスポンス用のプロトコル
public protocol QiitaResponse {
    
    init(response: HTTPURLResponse, json: Data) throws

}

extension QiitaResponse where Self: Decodable {
    
    public init(response: HTTPURLResponse, json: Data) throws {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        self = try jsonDecoder.decode(Self.self, from: json)
    }

}

extension Array: QiitaResponse {
    
}
