//
//  AuthWebViewController.swift
//  QiitaKit
//
//  Created by 山口　恭兵 on 2016/01/09.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import UIKit

import UIKit
import WebKit


internal final class AuthWebViewController: UIViewController {
    
    /* ====================================================================== */
    // MARK: - Properties
    /* ====================================================================== */
    
    internal var redirectURL: NSURL
    
    internal var request: NSURLRequest
    
    internal var webViewType: AuthWebViewType
    
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
    
    @IBAction func didTapCancelButton(sender: UIButton) {
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
    
    private init(request: NSURLRequest, redirectURL: NSURL!, webViewType: AuthWebViewType) {
        self.request = request
        self.redirectURL = redirectURL
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
            webView = UIWebView()
            
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
    
    
    static func showWithRequest(request: NSURLRequest, redirectURL: NSURL, webViewType: AuthWebViewType) {
        let window = UIWindow(frame:UIScreen.mainScreen().bounds)
        let rootViewController = AuthWebViewController(
            request: request,
            redirectURL: redirectURL,
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
                AuthManager.sharedManager.cancel()
                
                window.rootViewController?.view.removeFromSuperview()
                window.rootViewController = nil
                
                AuthWebViewController.window = nil
                
                if let window = UIApplication.sharedApplication().delegate?.window {
                    window?.makeKeyAndVisible()
                }
        })
    }
    
}


extension AuthWebViewController: WKNavigationDelegate {
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        guard let scheme = navigationAction.request.URL?.scheme else {
            decisionHandler(.Allow)
            return
        }
        
        switch scheme {
        case redirectURL.scheme:
            UIApplication.sharedApplication().openURL(navigationAction.request.URL!)
            decisionHandler(.Cancel)
            
        default:
            decisionHandler(.Allow)
            
        }
    }
    
}
