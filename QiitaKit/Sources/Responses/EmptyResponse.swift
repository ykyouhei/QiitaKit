//
//  EmptyResponse.swift
//  QiitaKit
//
//  Created by kyohei yamaguchi on 2018/03/11.
//  Copyright © 2018年 kyo__hei. All rights reserved.
//

import Foundation

/// 空のレスポンス
public struct EmptyResponse: QiitaResponse {
    
    public init(response: HTTPURLResponse, json: Data) throws {
    }
    
}
