//
//  Team.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import Unbox

/**
 Qiita:Team上で所属しているチームを表します。Qiita:Teamでのみ有効です
 
 https://qiita.com/api/v2/docs#%E3%83%81%E3%83%BC%E3%83%A0
 */
public struct Team: CustomStringConvertible {
    
    /// チームが利用可能な状態かどうか
    public let active: Bool
    
    /// チームの一意なID
    public let id: String
    
    /// チームに設定されている名前を表します
    public let name: String
    
}

extension Team: Unboxable {
    
    public init(unboxer: Unboxer) {
        active = unboxer.unbox(key: "active")
        id     = unboxer.unbox(key: "id")
        name   = unboxer.unbox(key: "name")
    }
    
}
