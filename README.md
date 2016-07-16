# QiitaKit

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Pod Version](http://img.shields.io/cocoapods/v/QiitaKit.svg?style=flat)](http://cocoadocs.org/docsets/QiitaKit/)
[![Pod Platform](http://img.shields.io/cocoapods/p/QiitaKit.svg?style=flat)](http://cocoadocs.org/docsets/QiitaKit/)
[![Pod License](http://img.shields.io/cocoapods/l/QiitaKit.svg?style=flat)](https://github.com/ykyohei/QiitaKit/blob/master/LICENSE)
![Swift version](https://img.shields.io/badge/swift-2.2-orange.svg)

Swift製のQiitaAPIClient（v2）です。OAuth認証にも対応しています。


# Usage

### セットアップ

[Qiitaマイページ](https://qiita.com/settings/applications) で登録したアプリケーションのClientID, ClientSecretを設定してください。

```Swift

// AppDelegate.swift
import QiitaKit

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    /*
     初期設定を行う
     
     - parameter clientID:                      登録アプリケーションのClientID
     - parameter clientSecret:                  登録アプリケーションのClientSecret
     - parameter teamDomain(Option):            QiitaTeamのドメイン(Optional)
     - parameter keychainConfiguration(Option): トークンを保存するKeychainの設定
    */
    AuthManager.sharedManager.setup(
       clientID: "xxxxx",
       clientSecret: "xxxxx")
       
    return true
    
}

```

### OAuth認証

```Swift
import QiitaKit

// 認証済み判定
let authorized: Bool = AuthManager.sharedManager.authorized

/*
OAuth認証を行う。認証を行うためのWindowが表示されます

- parameter scopes:      アプリで利用可能なスコープ
   - ReadQiita:      Qiitaからアクセストークンに紐付いたユーザに関連したデータを読み出す
   - ReadQiitaTeam:  Qiita:Teamからデータを読み出す
   - WriteQiita:     Qiitaにデータを書き込む
   - WriteQiitaTeam: Qiita:Teamにデータを書き込む
    
- parameter redirectURL: 登録アプリケーションで設定したリダイレクト先のURL

- parameter webViewType: OAuth認証を行うWebViewの種類

- parameter completion:  認証後に呼ばれるハンドラ

*/
AuthManager.sharedManager.authorize(withScopes: scopes,
                                    redirectURL: redirectURL,
                                    webViewType: .UIWebView)
{ result in
    switch result {
    case .Success:
        // 認証成功
        
    case .Failure(let error):
        // 認証失敗
    }
}

```

### リクエスト

QiitaAPIの各リクエストに対応ています。
* [いいね](./QiitaKit/Classes/Requests/Like)
* [コメント](./QiitaKit/Classes/Requests/Comment)
* [投稿とタグとの関連](./QiitaKit/Classes/Requests/Tagging)
* [タグ](./QiitaKit/Classes/Requests/Tag)
* [Qiita:Team上でのチーム](./QiitaKit/Classes/Requests/Team)
* [投稿のテンプレート](./QiitaKit/Classes/Requests/Template)
* [Qiita:Team上でのプロジェクト](./QiitaKit/Classes/Requests/Project)
* [Qiita上のユーザ](./QiitaKit/Classes/Requests/User)
* [投稿](./QiitaKit/Classes/Requests/Item)

```Swift
import QiitaKit
import APIKit
import Result

// 認証中ユーザ情報を取得するリクエストオブジェクト
let request = QiitaAPI.User.GetAuthenticatedUserRequest()

// リクエスト送信
Session.sendRequest(request) { result in
    switch result {
    case .Success(let authenticatedUser):
        print(authenticatedUser)
        
    case .Failure(let error):
        print(error)
    }
}

```

# Installation

### [Carthage](https://github.com/Carthage/Carthage)

- `github "ykyouhei/QiitaKit"` をCartfileに追記.
- `carthage update`を実行.
- `Carthage/Checkouts`以下に生成される `QiitaKit.framework` ,`APIKit.framework` , `Result.framework` をプロジェクトにリンク

### [CocoaPods](https://github.com/cocoapods/cocoapods)

- `pod 'QiitaKit'` をPodfileに追記
- Run `pod install`.

