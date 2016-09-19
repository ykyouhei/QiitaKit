//
//  User.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation
import Unbox

/**
 Qiita上のユーザを表します
 */
public struct User: CustomStringConvertible {
    
    /// 自己紹介文
    public let description: String?
    
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
    public let websiteURL: URL?
   
}

extension User: Unboxable {
    
    public init(unboxer: Unboxer) {
        id                = unboxer.unbox(key: "id")
        followeesCount    = unboxer.unbox(key: "followees_count")
        followersCount    = unboxer.unbox(key: "followers_count")
        itemsCount        = unboxer.unbox(key: "items_count")
        permanentID       = unboxer.unbox(key: "permanent_id")
        profileImageURL   = unboxer.unbox(key: "profile_image_url")
        description       = unboxer.unbox(key: "description")
        facebookID        = unboxer.unbox(key: "facebook_id")
        githubLoginName   = unboxer.unbox(key: "github_login_name")
        linkedinID        = unboxer.unbox(key: "linkedin_id")
        location          = unboxer.unbox(key: "location")
        name              = unboxer.unbox(key: "name")
        organization      = unboxer.unbox(key: "organization")
        twitterScreenName = unboxer.unbox(key: "twitter_screen_name")
        websiteURL        = unboxer.unbox(key: "website_url")
    }
    
}
