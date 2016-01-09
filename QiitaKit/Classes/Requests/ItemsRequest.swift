//
//  ItemsRequest.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import APIKit
import ObjectMapper

/**
 各種投稿一覧を返すリクエスト
 */
public struct ItemsRequest {
    
    /* ====================================================================== */
    // MARK: - Types
    /* ====================================================================== */
    
    /**
    投稿取得のタイプ
    */
    public enum Type {
        
        /// 認証中のユーザの投稿の一覧を作成日時の降順で返します
        case AuthenticatedUser
        
        /**
         クエリにマッチした投稿の一覧を作成日時の降順で返します
         - ex. "qiita user:yaotti"
        */
        case Search(query: String)

        /// 指定されたタグが付けられた投稿一覧をタグを付けた日時の降順で返します
        case Tag(tagID: String)
        
        /// 指定されたユーザの投稿一覧を作成日時の降順で返します
        case User(userID: String)

        /// 指定されたユーザがストックした投稿一覧をストックした日時の降順で返します
        case UserStoks(userID: String)
        
    }
    
    
    /* ====================================================================== */
    // MARK: - Properties
    /* ====================================================================== */
    
    /// 取得する投稿の種別
    public let type: Type
    
    /// ページ番号 (1から100まで)
    public var page: Int
    
    /// 1ページあたりに含まれる要素数 (1から100まで)
    public var perPage: Int
    
    
    public init(type: Type, page: Int = 1, perPage: Int = 20) {
        self.type    = type
        self.page    = page
        self.perPage = perPage
    }
    
}

extension ItemsRequest: QiitaPageableRequestType {
    
    public var method: HTTPMethod {
        return .GET
    }
    
    public var path: String {
        switch type {
        case .AuthenticatedUser:
            return "authenticated_user/items"
            
        case .Search:
            return "items"
            
        case .Tag(let tagID):
            return "tags/\(tagID)/items"
            
        case .User(let userID):
            return "users/\(userID)/items"
            
        case .UserStoks(let userID):
            return "users/\(userID)/stocks"
        }
    }
    
    public var parameters: [String : AnyObject] {
        var params = pageParamaters
        
        if case .Search(let query) = type {
            params["query"] = query
        }
        
        return params
    }
    
    public func responseFromObjects(object: AnyObject) -> [PostItem]? {
        guard let json = object as? [AnyObject] else {
            return nil
        }
        
        var items = [PostItem]()
        json.forEach {
            items.append(Mapper<PostItem>().map($0)!)
        }
        
        return items
    }
    
}
