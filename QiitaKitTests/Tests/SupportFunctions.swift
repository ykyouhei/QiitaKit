//
//  SupportFunctions.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

func readJSON(_ withName: String, forClass: AnyClass) -> Data {
    let bundle = Bundle(for: forClass)
    let jsonPath = bundle.path(forResource: withName, ofType: "json")
    return (try! Data(contentsOf: URL(fileURLWithPath: jsonPath!)))
}

func jsonDecoder() -> JSONDecoder {
    let d = JSONDecoder()
    d.dateDecodingStrategy = .iso8601
    return d
}
