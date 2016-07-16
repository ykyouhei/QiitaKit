//
//  ViewController.swift
//  Example
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import UIKit
import APIKit
import Result
import QiitaKit

var currentUser: AuthenticatedUser!

extension UIViewController {
    
    func showAlert(title: String,
                   message: String,
                   okHandler: ((UIAlertAction) -> ())? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: okHandler))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(error: ErrorType) {
        let title = "Error"
        let message = "\(error)"
        showAlert(title, message: message)
    }
    
}

internal final class LoginViewController: UIViewController {
    
    @IBAction private func didTapLoginButton(sender: UIButton) {
        let plistPath = NSBundle.mainBundle().pathForResource("Config", ofType: "plist")!
        let plist = NSDictionary(contentsOfFile: plistPath) as! [String:String]
        
        let redirectURL = NSURL(string: plist["redirectURL"]!)!
        let scopes: Set<Scope> = [.ReadQiita, .WriteQiita]
        
        AuthManager.sharedManager.authorize(withScopes: scopes,
                                            redirectURL: redirectURL,
                                            webViewType: .UIWebView)
        { result in
            switch result {
            case .Success:
                self.requestAuthenticatedUser()
                
            case .Failure(let error):
                self.showErrorAlert(error)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if AuthManager.sharedManager.authorized {
            requestAuthenticatedUser()
        }
    }
    
    private func requestAuthenticatedUser() {
        Session.sendRequest(QiitaAPI.User.GetAuthenticatedUserRequest()) { result in
            switch result {
            case .Success(let user):
                currentUser = user
                self.showAPITableViewController()
                
            case .Failure(let error):
                self.showErrorAlert(error)
            }
        }
    }
    
    private func showAPITableViewController() {
        performSegueWithIdentifier("showAPIs", sender: nil)
    }

}

