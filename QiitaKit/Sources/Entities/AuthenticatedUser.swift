//
//  AuthenticatedUser.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation

/// 現在のアクセストークンで認証中のユーザを表します。通常のユーザ情報よりも詳細な情報を含んでいます。
public struct AuthenticatedUser: Codable, CustomStringConvertible, QiitaResponse {
    
    /// 自己紹介文
    public let userDescription: String?
    
    /// Facebook ID
    public let facebookID: String?
    
    //// このユーザがフォローしているユーザの数
    public let followeesCount: Int
    
    /// このユーザをフォローしているユーザの数
    public let followersCount: Int
    
    /// GitHub ID
    public let githubLoginName: String?
    
    /// ユーザID
    public let id: String
    
    /// このユーザが qiita.com 上で公開している投稿の数 (Qiita:Teamでの投稿数は含まれません)
    public let itemsCount: Int
    
    /// LinkedIn ID
    public let linkedinID: String?
    
    /// 居住地
    public let location: String?
    
    /// 設定している名前
    public let name: String?
    
    /// 所属している組織
    public let organization: String?
    
    /// ユーザごとに割り当てられる整数のID
    public let permanentID: Int
    
    /// 設定しているプロフィール画像のURL
    public let profileImageURL: URL
    
    /// Twitterのスクリーンネーム
    public let twitterScreenName: String?
    
    /// 設定しているWebサイトのURL
    public let websiteURL: String?
    
    /// 1ヶ月あたりにQiitaにアップロードできる画像の総容量
    public let imageMonthlyUploadLimit: Int
    
    /// その月にQiitaにアップロードできる画像の残りの容量
    public let imageMonthlyUploadRemaining: Int
    
    /// Qiita:Team専用モードに設定されているかどうか
    public let teamOnly: Bool
    
}


extension AuthenticatedUser {
    
    enum CodingKeys: String, CodingKey {
        case id                          = "id"
        case followeesCount              = "followees_count"
        case followersCount              = "followers_count"
        case itemsCount                  = "items_count"
        case permanentID                 = "permanent_id"
        case profileImageURL             = "profile_image_url"
        case userDescription             = "description"
        case facebookID                  = "facebook_id"
        case githubLoginName             = "github_login_name"
        case linkedinID                  = "linkedin_id"
        case location                    = "location"
        case name                        = "name"
        case organization                = "organization"
        case twitterScreenName           = "twitter_screen_name"
        case websiteURL                  = "website_url"
        case imageMonthlyUploadLimit     = "image_monthly_upload_limit"
        case imageMonthlyUploadRemaining = "image_monthly_upload_remaining"
        case teamOnly                    = "team_only"
    }
    
}

