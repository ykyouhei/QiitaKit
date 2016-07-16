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
    
    internal var request: NSURLRequest
    
    internal var webViewType: AuthWebViewType
    
    private let authInfo: AuthManager.AuthInfo
    
    
    // UI
    
    static var window: UIWindow?
    
    private var webView: UIView! {
        didSet {
            webView.layer.cornerRadius = 5
            webView.clipsToBounds      = true
        }
    }
    
    
    /* ====================================================================== */
    // MARK: - Actions
    /* ====================================================================== */
    
    @IBAction private func didTapCancelButton(sender: UIButton) {
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
    
    private init(request: NSURLRequest,
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
        
        view.backgroundColor = UIColor.clearColor()
        
        switch webViewType {
        case .UIWebView:
            let uiWebView = UIWebView()
            uiWebView.delegate = self
            webView = uiWebView
            
        case .WKWebView:
            let wkWebView = WKWebView()
            wkWebView.navigationDelegate = self
            webView = wkWebView
        }
        
        webView.frame = view.bounds
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(webView)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-12-[webView]-12-|",
            options: [],
            metrics: nil,
            views: ["webView" : webView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[webView]-20-|",
            options: [],
            metrics: nil,
            views: ["webView" : webView]))
        
        switch webView {
        case let webView as UIWebView:  webView.loadRequest(request)
        case let webView as WKWebView:  webView.loadRequest(request)
        default:                        break
        }
    }
    
    /* ====================================================================== */
    // MARK: Internal Method
    /* ====================================================================== */
    
    static func showWithRequest(request: NSURLRequest,
                                authInfo: AuthManager.AuthInfo,
                                webViewType: AuthWebViewType)
    {
        let window = UIWindow(frame:UIScreen.mainScreen().bounds)
        let rootViewController = AuthWebViewController(
            request: request,
            authInfo: authInfo,
            webViewType: webViewType)
        
        rootViewController.request = request
        
        window.alpha = 0
        window.transform = CGAffineTransformMakeScale(1, 1)
        window.backgroundColor = UIColor(white:0, alpha: 0.6)
        window.windowLevel = UIWindowLevelNormal + 5
        window.rootViewController = rootViewController
        
        window.makeKeyAndVisible()
        
        AuthWebViewController.window = window
        
        UIView.transitionWithView(window,
            duration: 0.2,
            options: [.TransitionCrossDissolve, .CurveEaseInOut],
            animations: {
                window.alpha = 1
            }, completion: nil)
    }
    
    static func close() {
        guard let window = AuthWebViewController.window else { return }
        
        UIView.transitionWithView(window,
            duration: 0.2,
            options: [.TransitionCrossDissolve, .CurveEaseInOut],
            animations: {
                window.rootViewController?.view.subviews.forEach {
                    $0.transform = CGAffineTransformMakeScale(0.8, 0.8)
                }
                window.alpha = 0;
            }, completion: { finished in
                
                window.rootViewController?.view.removeFromSuperview()
                window.rootViewController = nil
                
                AuthWebViewController.window = nil
                
                if let window = UIApplication.sharedApplication().delegate?.window {
                    window?.makeKeyAndVisible()
                }
        })
    }
    
    
    /* ====================================================================== */
    // MARK: Private Method
    /* ====================================================================== */
    
    private func parse(redirectURL url: NSURL) {
        guard let state = url.fragments["state"],
            code = url.fragments["code"] where state == authInfo.state else
        {
            authInfo.completion(result: .Failure(.InvalidState))
            return
        }
        
        let accessTokenRequest = QiitaAPI.Authorization.AccessTokenRequest(
            clientID: AuthManager.sharedManager.clientID,
            clientSecret: AuthManager.sharedManager.clientSecret,
            code: code)
        
        Session.sendRequest(accessTokenRequest) { result in
            switch result {
            case .Success(let accessTokenResponse):
                AuthManager.sharedManager.accessToken = accessTokenResponse.token
                AuthWebViewController.close()
                self.authInfo.completion(result: .Success(true))
                
            case .Failure:
                self.authInfo.completion(result: .Failure(.FaildToGetAccessToken))
                
            }
            
        }
    }
    
    
}


// MARK: - WKNavigationDelegate

extension AuthWebViewController: WKNavigationDelegate {
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        guard let scheme = navigationAction.request.URL?.scheme else {
            decisionHandler(.Allow)
            return
        }
        
        switch scheme {
        case authInfo.redirectURL.scheme:
            parse(redirectURL: navigationAction.request.URL!)
            decisionHandler(.Cancel)
            
        default:
            decisionHandler(.Allow)
            
        }
    }
    
}


// MARK: - UIWebViewDelegate

extension AuthWebViewController: UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let scheme = request.URL?.scheme else {
            return true
        }
        
        switch scheme {
        case authInfo.redirectURL.scheme:
            parse(redirectURL: request.URL!)
            return false
            
        default:
            return true
            
        }
    }
    
}



