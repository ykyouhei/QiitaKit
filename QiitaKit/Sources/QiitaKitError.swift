//
//  QiitaKitError.swift
//  QiitaKit
//
//  Created by 山口　恭兵 on 2016/01/09.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

/// QiitaAPIからのエラー
public enum QiitaKitError: Error {
    
    case invalidRedirectScheme
    
    case invalidState
    
    case faildToGetAccessToken
    
    case alreadyStocked
    
    case apiError(APIError)
    
    case invalidJSON(Swift.Error)
    
    case unknown
    
    case urlSessionError(Swift.Error)
    
    internal init(object: Data) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        guard let error = try? jsonDecoder.decode(APIError.self, from: object) else {
            self = .unknown
            return
        }
        
        switch error.type {
        case "already_stocked": self = .alreadyStocked
        default:                self = .apiError(error)
        }
    }
    
}
