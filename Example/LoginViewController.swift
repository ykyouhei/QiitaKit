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
    
    func showAlert(_ title: String,
                   message: String,
                   okHandler: ((UIAlertAction) -> ())? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: okHandler))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(_ error: Error) {
        let title = "Error"
        let message = "\(error)"
        showAlert(title, message: message)
    }
    
}

internal final class LoginViewController: UIViewController {
    
    @IBAction fileprivate func didTapLoginButton(_ sender: UIButton) {
        let plistPath = Bundle.main.path(forResource: "Config", ofType: "plist")!
        let plist = NSDictionary(contentsOfFile: plistPath) as! [String:String]
        
        let redirectURL = URL(string: plist["redirectURL"]!)!
        let scopes: Set<Scope> = [.readQiita, .writeQiita]
        
        AuthManager.sharedManager.authorize(withScopes: scopes,
                                            redirectURL: redirectURL,
                                            webViewType: .uiWebView)
        { result in
            switch result {
            case .success:
                self.requestAuthenticatedUser()
                
            case .failure(let error):
                self.showErrorAlert(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AuthManager.sharedManager.authorized {
            requestAuthenticatedUser()
        }
    }
    
    fileprivate func requestAuthenticatedUser() {
        Session.send(QiitaAPI.User.GetAuthenticatedUserRequest()) { result in
            switch result {
            case .success(let user):
                currentUser = user
                self.showAPITableViewController()
                
            case .failure(let error):
                self.showErrorAlert(error)
            }
        }
    }
    
    fileprivate func showAPITableViewController() {
        performSegue(withIdentifier: "showAPIs", sender: nil)
    }

}

