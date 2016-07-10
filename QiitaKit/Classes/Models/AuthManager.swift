//
//  AuthManager.swift
//  QiitaKit
//
//  Created by 山口　恭兵 on 2016/01/09.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import Result
import APIKit

/**
 OAuthを行うWebViewの種類
 
 - UIWebView
 - WKWebView
 */
public enum AuthWebViewType {
    case UIWebView
    case WKWebView
}


/**
 Qiitaの認証を管理するクラス
 */
public final class AuthManager {
    
    /* ====================================================================== */
    // MARK: - Types
    /* ====================================================================== */
    
    public typealias AuthCompletionHandler = (result: Result<Bool, QiitaKitError>) -> Void
    
    internal typealias AuthInfo = (state: String, redirectURL: NSURL, completion: AuthCompletionHandler)
    
    private struct KeychainKey {
        static let accessToken = "accessToken"
        static let teamDomain  = "teamDomain"
    }
    
    
    /* ====================================================================== */
    // MARK: - Properties
    /* ====================================================================== */
    
    public static let sharedManager = AuthManager()
    
    /// アクセストークン
    public internal(set) var accessToken: String? {
        get { return try? keychain.read(withKey: KeychainKey.accessToken) }
        set {
            guard let newValue = newValue else {
                let _ = try? keychain.deleteItem(withKey: KeychainKey.accessToken)
                return
            }
            let _ = try? keychain.save(newValue, forKey: KeychainKey.accessToken)
        }
    }
    
    /// QiitaTeamのドメイン
    public internal(set) var teamDomain: String? {
        get { return try? keychain.read(withKey: KeychainKey.teamDomain) }
        set {
            guard let newValue = newValue else {
                let _ = try? keychain.deleteItem(withKey: KeychainKey.teamDomain)
                return
            }
            let _ = try? keychain.save(newValue, forKey: KeychainKey.teamDomain)
        }
    }
    
    /// Qiitaで認証済みかどうかを返す
    public var authorized: Bool {
        return accessToken != nil
    }
    
    public private(set) var clientID: String!
    
    public private(set) var clientSecret: String!
   
    public private(set) var keychainConfiguration: KeychainConfiguration!
    
    private var keychain: KeychainWrapper {
        return KeychainWrapper(config: keychainConfiguration)
    }
    
    private init() {}
    
    
    /* ====================================================================== */
    // MARK: - Public Method
    /* ====================================================================== */
    
    /**
     Qiitaの認証に関する初期設定を行う
     
     AppDelegateのdidFinishLaunchingWithOptionなどで設定してください
     
     - parameter clientID:              登録アプリケーションのClientID
     - parameter clientSecret:          登録アプリケーションのClientSecret
     - parameter teamDomain:            QiitaTeamのドメイン(Optional)
     - parameter keychainConfiguration: accessToken等を保存するKeychainの設定(Optional)
     */
    public func setup(clientID clientID: String,
                                      clientSecret: String,
                                      teamDomain: String? = nil,
                                      keychainConfiguration: KeychainConfiguration = KeychainConfiguration())
    {
        self.clientID              = clientID
        self.clientSecret          = clientSecret
        self.keychainConfiguration = keychainConfiguration
        if let teamDomain = teamDomain {
            self.teamDomain = teamDomain
        }
    }
    
    /**
     QiitaのOAuth認証を行う
     
     - parameter scopes:      アプリで利用可能なスコープ
     - parameter redirectURL: 登録アプリケーションで設定したリダイレクト先のURL
     - parameter webViewType: OAuth認証を行うWebViewの種類
     - parameter completion:  認証後に呼ばれるハンドラ
     */
    public func authorizeWithScope(scopes: Set<Scope>, redirectURL: NSURL, webViewType: AuthWebViewType, completion: AuthCompletionHandler) {
        let authInfo = (state: NSUUID().UUIDString, redirectURL: redirectURL, completion: completion)
        
        let request = QiitaAPI.AuthorizeRequest.init(
            clientID: clientID,
            scopes: scopes,
            state: authInfo.state)
        
        AuthWebViewController.showWithRequest(
            try! request.buildURLRequest(),
            authInfo: authInfo,
            webViewType: webViewType)
    }
    
}