//
//  NSURL+Fragments.swift
//  QiitaKit
//
//  Created by 山口　恭兵 on 2016/01/09.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

internal let ISO8601DateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter
}()

internal extension URL {
    
    var fragments: [String: String] {
        return URLComponents(string: absoluteString)?
            .queryItems?
            .reduce(into: [String : String]()) {
                $0[$1.name] = $1.value
            } ?? [:]
    }
    
}
