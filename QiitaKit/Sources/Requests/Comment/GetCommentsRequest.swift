//
//  GetCommentsRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation



public extension QiitaAPI.Comment {
    
    /// 投稿に付けられたコメント一覧を投稿日時の降順で取得します
    ///
    /// https://qiita.com/api/v2/docs#get-apiv2itemsitem_idcomments
    public struct GetCommentsRequest: QiitaRequest {
        
        public typealias Response = Array<Comment>
        
        // MARK: Properties
        
        /// 投稿ID
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
            return "items/\(itemID)/comments"
        }
        
    }
    
}
