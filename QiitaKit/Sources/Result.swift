//
//  Result.swift
//  QiitaKit
//
//  Created by kyohei yamaguchi on 2018/03/21.
//  Copyright © 2018年 kyo__hei. All rights reserved.
//

import Foundation

public enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}
