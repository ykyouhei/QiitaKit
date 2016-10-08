//
//  User.swift
//  Qiitag
//
//  Created by 山口　恭兵 on 2015/12/28.
//  Copyright © 2015年 kyo__hei. All rights reserved.
//

import Foundation


/**
 Qiita上のユーザを表します
 */
public struct User: CustomStringConvertible {
    
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
    public let websiteURL: URL?
   
}

extension User: JSONParsable {
    
    internal init(json: JSON) {
        print(json)
        id                = json["id"].string!
        followeesCount    = json["followees_count"].int!
        followersCount    = json["followers_count"].int!
        itemsCount        = json["items_count"].int!
        permanentID       = json["permanent_id"].int!
        profileImageURL   = json["profile_image_url"].url!
        userDescription   = json["description"].string
        facebookID        = json["facebook_id"].string
        githubLoginName   = json["github_login_name"].string
        linkedinID        = json["linkedin_id"].string
        location          = json["location"].string
        name              = json["name"].string
        organization      = json["organization"].string
        twitterScreenName = json["twitter_screen_name"].string
        websiteURL        = json["website_url"].url
    }
    
}
