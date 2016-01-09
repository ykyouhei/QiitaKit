//
//  NSURL+Fragments.swift
//  QiitaKit
//
//  Created by 山口　恭兵 on 2016/01/09.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

internal extension NSURL {
    var fragments: [String : String] {
        
        guard let URLComponents = NSURLComponents(string: absoluteString),
            items = URLComponents.queryItems else {
                return [:]
        }
        
        return items.reduce([String : String]()) { (var dic, item) in
            dic[item.name] = item.value
            return dic
        }
    }
}
