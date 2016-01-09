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
    
    /// 認証中のユーザ
    static private(set) var currentUser: AuthenticatedUser?
    
    
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
    
    /// 1ヶ月あたりにQiitaにアップロードできる画像の総容量
    private(set) var imageMonthlyUploadLimit: Int!
    
    /// その月にQiitaにアップロードできる画像の残りの容量
    private(set) var imageMonthlyUploadRemaining: Int!
    
    /// Qiita:Team専用モードに設定されているかどうか
    private(set) var teamOnly: Bool!
    
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
    
    
    /* ====================================================================== */
    // MARK: - Public Method
    /* ====================================================================== */
    
    /**
    認証中のユーザを取得する
    
    - parameter completion: 取得完了後に呼ばれるコールバック
    */
    static public func fetchCurrentUserWithCompletion(completion: (Result<AuthenticatedUser, Error>) -> Void) {
        Session.sendRequest(AuthenticatedUserRequest()) { result in
            switch result {
            case .Success(let user):
                
                currentUser = user
                
                completion(.Success(user))
                
            case .Failure:
                completion(Result.Failure(Error.Other(type: "", message: "")))
                
            }
        }
    }
    
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
        imageMonthlyUploadLimit     <- map["image_monthly_upload_limit"]
        imageMonthlyUploadRemaining <- map["image_monthly_upload_remaining"]
        teamOnly                    <- map["team_only"]
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

