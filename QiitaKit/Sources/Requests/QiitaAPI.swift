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


public struct APIClient<Request: QiitaRequest> {
    
    let urlSession: URLSession
    
    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    @discardableResult
    public func send(_ request: Request, completion: @escaping (Result<Request.Response, QiitaKitError>) -> Void) -> URLSessionDataTask {
        let task = urlSession.dataTask(with: request.asURLRequest()) { (data, urlResponse, error) in
            func execCompletionOnMainThread(_ result: Result<Request.Response, QiitaKitError>) {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            if let error = error {
                execCompletionOnMainThread(.failure(.urlSessionError(error)))
                return
            }
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                execCompletionOnMainThread(.failure(.unknown))
                return
            }
            
            switch httpResponse.statusCode {
            case 200, 201, 204:
                do {
                    let response = try Request.Response(response: httpResponse, json: data ?? Data())
                    execCompletionOnMainThread(.success(response))
                } catch let decodeError {
                    execCompletionOnMainThread(.failure(.invalidJSON(decodeError)))
                }
                
            default:
                let error = QiitaKitError(object: data ?? Data())
                execCompletionOnMainThread(.failure(error))
            }
        }
        
        task.resume()
        
        return task
    }
    
}

