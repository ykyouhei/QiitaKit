//
//  CustomStringConvertible+Default.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/09/20.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

extension CustomStringConvertible {
    public var description : String {
        var description: String = ""
        description = "***** \(type(of: self)) *****\n"
        
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}
