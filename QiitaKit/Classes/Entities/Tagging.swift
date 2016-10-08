//
//  Tagging.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation


/**
 投稿とタグとの関連を表します
 */
public struct Tagging: CustomStringConvertible {
    
    /// タグを特定するための一意な名前
    public let name: String
    
    /// このタグをフォローしているユーザの数
    public let versions: [String]
    
}

extension Tagging: JSONParsable {
    
    internal init(json: JSON) {
        name     = json["name"].string!
        versions = (json["versions"].object as? [String]) ?? []
    }
    
}
