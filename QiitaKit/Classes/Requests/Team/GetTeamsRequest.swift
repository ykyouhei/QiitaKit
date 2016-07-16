//
//  GetTeamsRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

public extension QiitaAPI.Team {
    
    /**
     ユーザが所属している全てのチームを、チーム作成日時の降順で返します
     
     https://qiita.com/api/v2/docs#get-apiv2teams
     */
    public struct GetTeamsRequest: QiitaRequestType {
        
        // MARK: Initialize
        
        public init() {}
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .GET
        }
        
        public var path: String {
            return "teams"
        }
        
        public func responseFromObject(object: AnyObject,
                                       URLResponse: NSHTTPURLResponse) throws -> [Team] {
            guard let json = object as? [[String: AnyObject]] else { throw QiitaKitError.InvalidJSON }
            return try Unbox(json)
        }
        
    }
    
}
