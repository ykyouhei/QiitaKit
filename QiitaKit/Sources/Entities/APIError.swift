//
//  APIError.swift
//  QiitaKit
//
//  Created by kyohei yamaguchi on 2018/03/21.
//  Copyright © 2018年 kyo__hei. All rights reserved.
//

import Foundation

/// API共通のエラー
public struct APIError: Codable, CustomStringConvertible {
    
    public let message: String
    
    public let type: String
    
}
