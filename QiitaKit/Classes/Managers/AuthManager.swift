//
//  AuthManager.swift
//  QiitaKit
//
//  Created by 山口　恭兵 on 2016/01/09.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

import Foundation
import KeychainAccess
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

public final class AuthManager {
    
    /* ====================================================================== */
    // MARK: - Types
    /* ====================================================================== */
    
    private struct KeychainKey {
        static let accessToken = "accessToken"
        static let teamDomain  = "teamDomain"
    }
    
    public typealias AuthCompletionHandler = (result: Result<Bool, QiitaKitError>) -> Void
    
    
    /* ====================================================================== */
    // MARK: - Properties
    /* ====================================================================== */
    
    private static let keychain = Keychain(service: "com.kyo--hei.GitHubKit")
    
    public static let sharedManager = AuthManager()
    
    private(set) static var accessToken: String? {
        get { return keychain[KeychainKey.accessToken] }
        set { keychain[KeychainKey.accessToken] = newValue }
    }
    
    public static var teamDomain: String? {
        get { return keychain[KeychainKey.teamDomain] }
        set { keychain[KeychainKey.teamDomain] = newValue }
    }
    
    public static var authorized: Bool {
        return accessToken != nil
    }
    
    public static var clientID = ""
    
    public static var clientSecret = ""
    
    private var authInfo: (state: String, redirectURL: NSURL, completion: AuthCompletionHandler)?
    
    
    /* ====================================================================== */
    // MARK: - Public Method
    /* ====================================================================== */
    
    public static func setup(clientID clientID: String, clientSecret: String) {
        self.clientID     = clientID
        self.clientSecret = clientSecret
    }
    
    public func authorizeWithScope(scopes: Set<Scope>, redirectURL: NSURL, webViewType: AuthWebViewType, completion: AuthCompletionHandler) {
        let authInfo = (state: NSUUID().UUIDString, redirectURL: redirectURL, completion: completion)
        
        let request = AuthorizeRequest.init(
            clientID: self.dynamicType.clientID,
            scopes: scopes,
            state: authInfo.state)
        
        self.authInfo = authInfo
        
        AuthWebViewController.showWithRequest(
            request.buildURLRequest().value!,
            redirectURL: authInfo.redirectURL,
            webViewType: webViewType)
    }
    
    public func handleOpenURL(url: NSURL) -> Bool {
        defer {
            AuthWebViewController.close()
        }
        
        // TODO: エラーハンドリング
        guard let authInfo = authInfo else {
            return false
        }
        
        guard url.scheme == authInfo.redirectURL.scheme else {
            authInfo.completion(result: .Failure(.InvalidRedirectScheme))
            return false
        }
        
        guard let state = url.fragments["state"],
            code = url.fragments["code"] where state == authInfo.state else
        {
            authInfo.completion(result: .Failure(.InvalidState))
            return false
        }
        
        let accessTokenRequest = AccessTokenRequest(
            clientID: self.dynamicType.clientID,
            clientSecret: self.dynamicType.clientSecret,
            code: code)
        
        Session.sendRequest(accessTokenRequest) { result in
            switch result {
            case .Success(let accessTokenResponse):
                AuthManager.accessToken = accessTokenResponse.token
                
                authInfo.completion(result: .Success(true))
                
            case .Failure:
                authInfo.completion(result: .Failure(.FaildToGetAccessToken))
                break
            }
            
        }
        
        return true
    }
    
    
    internal func cancel() {
        authInfo = nil
    }
    
}