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
        let type = "\(type(of: self))"
        let selfMirror = Mirror(reflecting: self)
        let property = selfMirror.children.reduce("") {
            $1.label != nil ? $0 + "    \($1.label!) = \($1.value)\n" : $0
        }
        
        return "<\(type)> {\n\(property)\n}"
    }
}
