//
//  QiitaAPI.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/16.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

/**
 QiitaのAPIクラス
 
 Extensinoで各エンドポイント用のリクエストが実装されています
 */
public struct QiitaAPI {
    
    /// 認証に関するリクエスト
    public struct Authorization {}
    
    /// いいねに関するリクエスト
    public struct Like {}
    
    /// Groupに関するリクエスト
    public struct Group {}
    
    /// コメントに関するリクエスト
    public struct Comment {}
    
    /// 投稿とタグとの関連に関するリクエスト
    public struct Tagging {}
    
    /// タグに関するリクエスト
    public struct Tag {}
    
    /// Qiita:Team上でのチームに関するリクエスト（Qiita:Teamでのみ有効）
    public struct Team {}
    
    /// 投稿のテンプレートに関するリクエスト
    public struct Template {}
    
    /// Qiita:Team上でのプロジェクトに関するリクエスト（Qiita:Teamでのみ有効）
    public struct Project {}
    
    /// Qiita上のユーザに関するリクエスト
    public struct User {}
    
    /// 投稿に関するリクエスト
    public struct Item {}

}

