//
//  AuthenticatedUser.swift
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
 現在のアクセストークンで認証中のユーザを表します。通常のユーザ情報よりも詳細な情報を含んでいます。
 */
public struct AuthenticatedUser {
    
    /// 自己紹介文
    public private(set) var description: String?
    
    /// Facebook ID
    public private(set) var facebookID: String?
    
    //// このユーザがフォローしているユーザの数
    public private(set) var followeesCount: Int!
    
    /// このユーザをフォローしているユーザの数
    public private(set) var followersCount: Int!
    
    /// GitHub ID
    public private(set) var githubLoginName: String?
    
    /// ユーザID
    public private(set) var id: String!
    
    /// このユーザが qiita.com 上で公開している投稿の数 (Qiita:Teamでの投稿数は含まれません)
    public private(set) var itemsCount: Int!
    
    /// LinkedIn ID
    public private(set) var linkedinID: String?
    
    /// 居住地
    public private(set) var location: String?
    
    /// 設定している名前
    public private(set) var name: String?
    
    /// 所属している組織
    public private(set) var organization: String?
    
    /// ユーザごとに割り当てられる整数のID
    public private(set) var permanentID: Int!
    
    /// 設定しているプロフィール画像のURL
    public private(set) var profileImageURL: NSURL!
    
    /// Twitterのスクリーンネーム
    public private(set) var twitterScreenName: String?
    
    /// 設定しているWebサイトのURL
    public private(set) var websiteURL: NSURL?
    
    /// 1ヶ月あたりにQiitaにアップロードできる画像の総容量
    public private(set) var imageMonthlyUploadLimit: Int!
    
    /// その月にQiitaにアップロードできる画像の残りの容量
    public private(set) var imageMonthlyUploadRemaining: Int!
    
    /// Qiita:Team専用モードに設定されているかどうか
    public private(set) var teamOnly: Bool!
    
}


extension AuthenticatedUser: Mappable {
    
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
        
        imageMonthlyUploadLimit     <- map["image_monthly_upload_limit"]
        imageMonthlyUploadRemaining <- map["image_monthly_upload_remaining"]
        teamOnly                    <- map["team_only"]
    }
    
}

