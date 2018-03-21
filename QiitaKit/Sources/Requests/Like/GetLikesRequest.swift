//
//  GetLikesRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public extension QiitaAPI.Like {
    
    /// 投稿につけられた「いいね！」を作成日時の降順で返します
    ///
    /// https://qiita.com/api/v2/docs#get-apiv2itemsitem_idlikes
    public struct GetLikesRequest: QiitaRequest {
        
        public typealias Response = Array<Tag>
        
        // MARK: Properties
        
        /// 投稿のID
        public let itemID: String
        
        
        // MARK: Initialize
        
        public init(itemID: String) {
            self.itemID = itemID
        }
        
        
        // MARK: QiitaRequest
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "items/\(itemID)/likes"
        }
        
    }
    
}
