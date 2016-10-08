//
//  JSONParsable.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/10/08.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

internal struct JSON {
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        return formatter
    }()
    
    let object: AnyObject
    
    init(_ any: Any) {
        self.object = any as AnyObject
    }
    
    init(_ data: Data) {
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        self.object = json as AnyObject
    }
    
    subscript(key: String) -> JSON {
        guard let value = object.value(forKey: key) else { return self }
        return JSON(value)
    }
    
    var bool:   Bool?   { return object as? Bool }
    var string: String? { return object as? String }
    var int:    Int?    { return object as? Int }
    var float:  Float?  { return object as? Float }
    var double: Double? { return object as? Double }
    var url:    URL?    { return string.flatMap{ URL(string: $0) } }
    var date:   Date?   { return string.flatMap{ JSON.formatter.date(from: $0) } }
    
}

internal protocol JSONParsable {
    
    init(json: JSON)
    
}

internal extension JSONParsable {
    
    init(data: Data) {
        self.init(json: JSON(data))
    }
    
}
