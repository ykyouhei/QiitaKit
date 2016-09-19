//
//  PostItemRequest.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import Unbox

public extension QiitaAPI.Item {
    
    /**
     新たに投稿を作成します
     
     https://qiita.com/api/v2/docs#post-apiv2items
     */
    public struct PostItemRequest: QiitaRequestType {
        
        // MARK: Properties
        
        /// 投稿のタイトル
        public let title: String
        
        /// Markdown形式の本文
        public let body: String
        
        /// この投稿が共同更新状態かどうか (Qiita:Teamでのみ有効)
        public let coediting: Bool
        
        /// 本文中のコードをGistに投稿するかどうか (GitHub連携を有効化している場合のみ有効)
        public let postToGist: Bool
        
        /// Twitterに投稿するかどうか (Twitter連携を有効化している場合のみ有効)
        public let postToTwitter: Bool
       
        /// 限定共有状態かどうかを表すフラグ (Qiita:Teamでは無効)
        public let privated: Bool
        
        /// 投稿に付いたタグ一覧
        public let tags: [Tagging]
        
        
        // MARK: Initialize
        
        public init(title: String,
                    body: String,
                    coediting: Bool = false,
                    postToGist: Bool = false,
                    postToTwitter: Bool = false,
                    privated: Bool = false,
                    tags: [Tagging] = []) {
            self.title         = title
            self.body          = body
            self.coediting     = coediting
            self.postToGist    = postToGist
            self.postToTwitter = postToTwitter
            self.privated      = privated
            self.tags          = tags
        }
        
        
        // MARK: QiitaRequestType
        
        public var method: HTTPMethod {
            return .post
        }
        
        public var path: String {
            return "items"
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
                "gist": postToGist,
                "private": privated,
                "tags": tagParams,
                "title": title,
                "tweet": postToTwitter
            ]
        }
        
        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Item {
            guard let json = object as? [String: AnyObject] else {
                throw QiitaKitError.invalidJSON
            }
            return try Unbox(dictionary: json)
        }
        
    }
    
}
