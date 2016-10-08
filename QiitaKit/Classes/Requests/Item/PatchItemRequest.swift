//
//  PatchItemRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit


public extension QiitaAPI.Item {
    
    /**
     投稿を取得します
     
     https://qiita.com/api/v2/docs#get-apiv2itemsitem_id
     */
    public struct PatchItemRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// 投稿のタイトル
        public let title: String
        
        /// Markdown形式の本文
        public let body: String
        
        /// 更新する投稿ID
        public let itemID: String
        
        /// この投稿が共同更新状態かどうか (Qiita:Teamでのみ有効)
        public let coediting: Bool
        
        /// 限定共有状態かどうかを表すフラグ (Qiita:Teamでは無効)
        public let privated: Bool
        
        /// 投稿に付いたタグ一覧
        public let tags: [Tagging]
        
        
        
        // MARK: Initialize
        
        public init(itemID: String,
                    title: String,
                    body: String,
                    coediting: Bool = false,
                    privated: Bool = false,
                    tags: [Tagging] = []) {
            self.itemID        = itemID
            self.title         = title
            self.body          = body
            self.coediting     = coediting
            self.privated      = privated
            self.tags          = tags
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .patch
        }
        
        public var path: String {
            return "items/\(itemID)"
        }
        
        public var parameters: Any? {
            let tagParams = tags.map {
                [
                    "name"     : $0.name,
                    "versions" : $0.versions
                ]
            }
            return [
                "body": body,
                "coediting": coediting,
                "private": privated,
                "tags": tagParams,
                "title": title,
            ]
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Item {
            return Item(json: JSON(object))
        }
        
    }
    
}
