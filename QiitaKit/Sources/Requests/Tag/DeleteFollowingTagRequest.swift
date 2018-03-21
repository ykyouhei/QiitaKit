//
//  DeleteFollowingRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Tag {
    
    /// タグのフォローを外します
    ///
    /// https://qiita.com/api/v2/docs#delete-apiv2tagstag_idfollowing
    public struct DeleteFollowingRequest: QiitaRequest {
        
        public typealias Response = EmptyResponse
        
        // MARK: Properties
        
        /// フォローを外すタグID
        public let tagID: String
        
        
        // MARK: Initialize
        
        public init(tagID: String) {
            self.tagID = tagID
        }
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .delete
        }
        
        public var path: String {
            return "tags/\(tagID)/following"
        }
        
    }
    
}
