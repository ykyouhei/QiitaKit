//
//  User.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import ObjectMapper
import APIKit
import Result

/**
 Qiita上のユーザを表します
 */
public struct User: Mappable {
    
    /// ユーザID
    private(set) var id: String!
    
    //// このユーザがフォローしているユーザの数
    private(set) var followeesCount: Int!
    
    /// このユーザをフォローしているユーザの数
    private(set) var followersCount: Int!
    
    /// このユーザが qiita.com 上で公開している投稿の数 (Qiita:Teamでの投稿数は含まれません)
    private(set) var itemsCount: Int!
    
    /// ユーザごとに割り当てられる整数のID
    private(set) var permanentID: Int!
    
    /// 設定しているプロフィール画像のURL
    private(set) var profileImageURL: NSURL!
    
    /// 自己紹介文
    private(set) var description: String?
    
    /// Facebook ID
    private(set) var facebookID: String?
    
    /// GitHub ID
    private(set) var githubLoginName: String?
    
    /// LinkedIn ID
    private(set) var linkedinID: String?
    
    /// 居住地
    private(set) var location: String?
    
    /// 設定している名前
    private(set) var name: String?
    
    /// 所属している組織
    private(set) var organization: String?
    
    /// Twitterのスクリーンネーム
    private(set) var twitterScreenName: String?
    
    /// 設定しているWebサイトのURL
    private(set) var websiteURL: NSURL?
    
    
    public init?(_ map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        id                          <- map["id"]
        followeesCount              <- map["followees_count"]
        followersCount              <- map["followers_count"]
        itemsCount                  <- map["items_count"]
        permanentID                 <- map["permanent_id"]
        profileImageURL             <- (map["profile_image_url"], URLTransform())
        description                 <- map["description"]
        facebookID                  <- map["facebook_id"]
        githubLoginName             <- map["github_login_name"]
        linkedinID                  <- map["linkedin_id"]
        location                    <- map["location"]
        name                        <- map["name"]
        organization                <- map["organization"]
        twitterScreenName           <- map["twitter_screen_name"]
        websiteURL                  <- (map["website_url"], URLTransform())
    }
}