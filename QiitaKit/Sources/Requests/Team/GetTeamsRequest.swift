//
//  GetTeamsRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Team {
    
    /// ユーザが所属している全てのチームを、チーム作成日時の降順で返します
    ///
    /// https://qiita.com/api/v2/docs#get-apiv2teams
    public struct GetTeamsRequest: QiitaRequest {
        
        public typealias Response = Array<Team>
        
        // MARK: Initialize
        
        public init() {}
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "teams"
        }

    }
    
}
