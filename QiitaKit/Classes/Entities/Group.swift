//
//  Group.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation
import Unbox

/**
 Qiita:Teamのグループを表します
 
 https://qiita.com/api/v2/docs#グループ
 */
public struct Group: CustomStringConvertible {
    
    /// データが作成された日時
    public let createdAt: Date
    
    /// グループの一意なIDを表します
    public let id: Int
    
    /// グループに付けられた表示用の名前を表します
    public let name: String
    
    /// グループに付けられた表示用の名前を表します
    public let privated: Bool
    
    /// データが最後に更新された日時
    public let updatedAt: Date
    
    /// グループのチーム上での一意な名前を表します
    public let urlName: String
    
}

extension Group: Unboxable {
    
    public init(unboxer: Unboxer) {
        createdAt = unboxer.unbox(key: "created_at", formatter: ISO8601DateFormatter)
        id        = unboxer.unbox(key: "id")
        name      = unboxer.unbox(key: "name")
        privated  = unboxer.unbox(key: "private")
        updatedAt = unboxer.unbox(key: "updated_at", formatter: ISO8601DateFormatter)
        urlName   = unboxer.unbox(key: "url_name")
    }
    
}
