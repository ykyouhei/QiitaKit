//
//  APITableViewController.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import UIKit
import QiitaKit

internal final class APITableViewController: UITableViewController {
    
    fileprivate var successObject: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = currentUser.name
        
        navigationController?.delegate = self
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).row {
        case 0:
            send(QiitaAPI.User.GetAuthenticatedUserRequest())
            
        case 1:
            send(QiitaAPI.User.GetUsersRequest(
                page: 1,
                perPage: 10)
            )
            
        case 2:
            send(QiitaAPI.User.GetFolloweesRequest(
                userID: currentUser.id,
                page: 1,
                perPage: 10)
            )
            
         case 3:
            send(QiitaAPI.User.GetFollowersRequest(
                userID: currentUser.id,
                page: 1,
                perPage: 10)
            )
            
          case 4:
            send(QiitaAPI.Item.GetItemsRequest(
                type: .authenticatedUser,
                page: 1,
                perPage: 10)
            )
            
        case 5:
            send(QiitaAPI.Tag.GetFollowingTagsRequest(
                userID: currentUser.id,
                page: 1,
                perPage: 10)
            )
            
            
        default:
            break
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let vc as RequestViewController:
            vc.object = successObject
        default:
            break
        }
    }
    
    func send<T: QiitaRequest>(_ request: T) {
        let indicator = UIActivityIndicatorView(frame: view.bounds)
        indicator.startAnimating()
        indicator.activityIndicatorViewStyle = .gray
        view.addSubview(indicator)
        
        APIClient().send(request) { result in
            indicator.removeFromSuperview()
            
            switch result {
            case .success(let object):
                print(object)
                self.successObject = object
                self.performSegue(withIdentifier: "showRequest", sender: nil)
                
            case .failure(let error):
                self.showErrorAlert(error)
            }
        }
    }
    
}

extension APITableViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                                                     animated: Bool) {
        if viewController is LoginViewController {
            let _ = try? AuthManager.sharedManager.logout()
        }
    }
    
}
