//
//  Group.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation


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

extension Group: JSONParsable {
    
    internal init(json: JSON) {
        createdAt = json["created_at"].date!
        id        = json["id"].int!
        name      = json["name"].string!
        privated  = json["private"].bool!
        updatedAt = json["updated_at"].date!
        urlName   = json["url_name"].string!
    }
    
}
