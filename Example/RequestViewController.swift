//
//  RequestViewController.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import UIKit
import QiitaKit

class RequestViewController: UIViewController {
    
    var object: Any!
    
    @IBOutlet fileprivate weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = "\(object))".replacingOccurrences(of: ",", with: "\n")
    }

}
