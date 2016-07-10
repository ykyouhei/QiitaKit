//
//  SupportFunctions.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

func readJSON(withName: String, forClass: AnyClass) -> NSData {
    let bundle = NSBundle(forClass: forClass)
    let jsonPath = bundle.pathForResource(withName, ofType: "json")
    return NSData(contentsOfFile: jsonPath!)!
}
