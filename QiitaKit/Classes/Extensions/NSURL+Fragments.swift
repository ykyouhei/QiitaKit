//
//  NSURL+Fragments.swift
//  QiitaKit
//
//  Created by 山口　恭兵 on 2016/01/09.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

internal let ISO8601DateFormatter: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter
}()

internal extension NSURL {
    var fragments: [String : String] {
        
        guard let URLComponents = NSURLComponents(string: absoluteString),
            items = URLComponents.queryItems else {
                return [:]
        }
        
        return items.reduce([String : String]()) { (dic, item) in
            var dic = dic
            dic[item.name] = item.value
            return dic
        }
    }
}
