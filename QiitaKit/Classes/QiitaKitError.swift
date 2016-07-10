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
public enum QiitaKitError: ErrorType {
    
    case InvalidRedirectScheme
    
    case InvalidState
    
    case FaildToGetAccessToken
    
    case AlreadyStocked
    
    case CommonError(message: String, type: String)
    
    case InvalidJSON
    
    case Unknown
    
    internal init(object: AnyObject) {
        guard let json = object as? [String : String],
            type = json["type"],
            message = json["message"] else
        {
            self = .Unknown
            return
        }
        
        switch type {
        case "already_stocked": self = .AlreadyStocked
        default:                self = CommonError(message: message, type: type)
        }
    }
    
}
