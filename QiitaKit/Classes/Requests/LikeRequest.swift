//
//  LikeRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

extension QiitaAPI {
    
    /**
     投稿につけられた「いいね！」を作成日時の降順で返します
     
     https://qiita.com/api/v2/docs#get-apiv2itemsitem_idlikes
     */
    public struct LikeRequest: QiitaRequestType {
        
        public let itemID: String
        
        public init(itemID: String) {
            self.itemID = itemID
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .GET
        }
        
        public var path: String {
            return "items/\(itemID)/likes"
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> [Tag] {
            guard let json = object as? [[String: AnyObject]] else { throw QiitaKitError.InvalidJSON }
            return try Unbox(json)
        }
        
    }
    
}
    