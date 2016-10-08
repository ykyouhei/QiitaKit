//
//  QiitaKitError.swift
//  QiitaKit
//
//  Created by 山口　恭兵 on 2016/01/09.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

/**
 QiitaAPIからのエラー
 
 - CommonError: 共通のエラー
 */
public enum QiitaKitError: Error {
    
    case invalidRedirectScheme
    
    case invalidState
    
    case faildToGetAccessToken
    
    case alreadyStocked
    
    case commonError(message: String, type: String)
    
    case invalidJSON
    
    case unknown
    
    internal init(object: Any) {
        guard let json = object as? [String : String],
            let type = json["type"],
            let message = json["message"] else
        {
            self = .unknown
            return
        }
        
        switch type {
        case "already_stocked": self = .alreadyStocked
        default:                self = .commonError(message: message, type: type)
        }
    }
    
}
