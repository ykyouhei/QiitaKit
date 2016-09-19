//
//  AuthWebViewController.swift
//  QiitaKit
//
//  Created by 山口　恭兵 on 2016/01/09.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import UIKit
import WebKit
import APIKit

internal final class AuthWebViewController: UIViewController {
    
    /* ====================================================================== */
    // MARK: - Properties
    /* ====================================================================== */
    
    internal var request: URLRequest
    
    internal var webViewType: AuthWebViewType
    
    fileprivate let authInfo: AuthManager.AuthInfo
    
    
    // UI
    
    static var window: UIWindow?
    
    private var webView: UIView? {
        didSet {
            webView?.layer.cornerRadius = 5
            webView?.clipsToBounds      = true
        }
    }
    
    
    /* ====================================================================== */
    // MARK: - Actions
    /* ====================================================================== */
    
    @IBAction private func didTapCancelButton(_ sender: UIButton) {
        switch webView {
        case let webView as UIWebView:  webView.stopLoading()
        case let webView as WKWebView:  webView.stopLoading()
        default:                        break
        }
        
        AuthWebViewController.close()
    }
    
    
    /* ====================================================================== */
    // MARK: - initializer
    /* ====================================================================== */
    
    private init(request: URLRequest,
                 authInfo: AuthManager.AuthInfo,
                 webViewType: AuthWebViewType)
    {
        self.request     = request
        self.authInfo    = authInfo
        self.webViewType = webViewType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /* ====================================================================== */
    // MARK: - View Life Cycle
    /* ====================================================================== */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        switch webViewType {
        case .uiWebView:
            let uiWebView = UIWebView()
            uiWebView.delegate = self
            webView = uiWebView
            
        case .wkWebView:
            let wkWebView = WKWebView()
            wkWebView.navigationDelegate = self
            webView = wkWebView
        }
        
        webView!.frame = view.bounds
        webView!.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(webView!)
        
        let constraints = [
            NSLayoutConstraint(
                item: webView!,
                attribute: .top,
                relatedBy: .equal,
                toItem: view,
                attribute: .top,
                multiplier: 1,
                constant: 20),
            NSLayoutConstraint(
                item: webView!,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: view,
                attribute: .bottom,
                multiplier: 1,
                constant: -20),
            NSLayoutConstraint(
                item: webView!,
                attribute: .left,
                relatedBy: .equal,
                toItem: view,
                attribute: .left,
                multiplier: 1,
                constant: 12),
            NSLayoutConstraint(
                item: webView!,
                attribute: .right,
                relatedBy: .equal,
                toItem: view,
                attribute: .right,
                multiplier: 1,
                constant: -12)
        ]

        view.addConstraints(constraints)
        
        switch webView {
        case let webView as UIWebView:  webView.loadRequest(request)
        case let webView as WKWebView:  webView.load(request)
        default:                        break
        }
    }
    
    /* ====================================================================== */
    // MARK: Internal Method
    /* ====================================================================== */
    
    static func show(withRequest request: URLRequest,
                                authInfo: AuthManager.AuthInfo,
                                webViewType: AuthWebViewType)
    {
        let window = UIWindow(frame:UIScreen.main.bounds)
        let rootViewController = AuthWebViewController(
            request: request,
            authInfo: authInfo,
            webViewType: webViewType)
        
        rootViewController.request = request
        
        window.alpha = 0
        window.transform = CGAffineTransform(scaleX: 1, y: 1)
        window.backgroundColor = UIColor(white:0, alpha: 0.6)
        window.windowLevel = UIWindowLevelNormal + 5
        window.rootViewController = rootViewController
        
        window.makeKeyAndVisible()
        
        AuthWebViewController.window = window
        
        UIView.transition(with: window,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: {
                window.alpha = 1
            }, completion: nil)
    }
    
    static func close() {
        guard let window = AuthWebViewController.window else { return }
        
        UIView.transition(with: window,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: {
                window.rootViewController?.view.subviews.forEach {
                    $0.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }
                window.alpha = 0;
            }, completion: { finished in
                
                window.rootViewController?.view.removeFromSuperview()
                window.rootViewController = nil
                
                AuthWebViewController.window = nil
                
                if let window = UIApplication.shared.delegate?.window {
                    window?.makeKeyAndVisible()
                }
        })
    }
    
    
    /* ====================================================================== */
    // MARK: Private Method
    /* ====================================================================== */
    
    fileprivate func parse(redirectURL url: URL) {
        guard let state = url.fragments["state"],
            let code = url.fragments["code"], state == authInfo.state
        else {
            authInfo.completion(.failure(.invalidState))
            return
        }
        
        let accessTokenRequest = QiitaAPI.Authorization.AccessTokenRequest(
            clientID: AuthManager.sharedManager.clientID,
            clientSecret: AuthManager.sharedManager.clientSecret,
            code: code)
        
        Session.send(accessTokenRequest) { result in
            switch result {
            case .success(let accessTokenResponse):
                AuthManager.sharedManager.accessToken = accessTokenResponse.token
                AuthWebViewController.close()
                self.authInfo.completion(.success(true))
                
            case .failure:
                self.authInfo.completion(.failure(.faildToGetAccessToken))
                
            }
            
        }
    }
    
    
}


// MARK: - WKNavigationDelegate

extension AuthWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let scheme = navigationAction.request.url?.scheme else {
            decisionHandler(.allow)
            return
        }
        
        switch scheme {
        case authInfo.redirectURL.scheme!:
            parse(redirectURL: navigationAction.request.url!)
            decisionHandler(.cancel)
            
        default:
            decisionHandler(.allow)
            
        }
    }
    
}


// MARK: - UIWebViewDelegate

extension AuthWebViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let scheme = request.url?.scheme else {
            return true
        }
        
        switch scheme {
        case authInfo.redirectURL.scheme!:
            parse(redirectURL: request.url!)
            return false
            
        default:
            return true
            
        }
    }
    
}



