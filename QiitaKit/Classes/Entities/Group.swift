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
public struct Group {
    
    /// データが作成された日時
    public let createdAt: NSDate
    
    /// グループの一意なIDを表します
    public let id: Int
    
    /// グループに付けられた表示用の名前を表します
    public let name: String
    
    /// グループに付けられた表示用の名前を表します
    public let privated: Bool
    
    /// データが最後に更新された日時
    public let updatedAt: NSDate
    
    /// グループのチーム上での一意な名前を表します
    public let urlName: String
    
}

extension Group: Unboxable {
    
    public init(unboxer: Unboxer) {
        createdAt = unboxer.unbox("created_at", formatter: ISO8601DateFormatter)
        id        = unboxer.unbox("id")
        name      = unboxer.unbox("name")
        privated = unboxer.unbox("private")
        updatedAt = unboxer.unbox("updated_at", formatter: ISO8601DateFormatter)
        urlName   = unboxer.unbox("url_name")
    }
    
}
