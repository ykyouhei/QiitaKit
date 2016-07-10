//
//  KeychainWrapper.swift
//  QiitaKit
//
//  Created by kyo__hei on 2016/07/10.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import Foundation

public struct KeychainConfiguration {
    
    let service: String
    
    let accessGroup: String?
    
    public init(service: String = "com.kyo--hei.QiitaKit",
                accessGroup: String? = nil)
    {
        self.service     = service
        self.accessGroup = accessGroup
    }
    
}

internal struct KeychainWrapper {
    
    // MARK: Types
    
    enum KeychainError: ErrorType {
        case noPassword
        case unexpectedPasswordData
        case unexpectedItemData
        case unhandledError(status: OSStatus)
    }
    
    // MARK: Properties
    
    let config: KeychainConfiguration
    
    
    // MARK: Intialization
    
    init(config: KeychainConfiguration) {
        self.config = config
    }
    
    // MARK: Keychain access
    
    func keychainQuery(withKey key: String) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = config.service
        query[kSecAttrAccount as String] = key
        
        if let accessGroup = config.accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup
        }
        
        return query
    }
    
    
    func read(withKey key: String) throws -> String  {
        var query = keychainQuery(withKey: key)
        query[kSecMatchLimit as String]       = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String]       = kCFBooleanTrue
        
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(&queryResult) {
            SecItemCopyMatching(query, UnsafeMutablePointer($0))
        }
        
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        
        guard let existingItem = queryResult as? [String : AnyObject],
            passwordData = existingItem[kSecValueData as String] as? NSData,
            password = String(data: passwordData, encoding: NSUTF8StringEncoding)
            else {
                throw KeychainError.unexpectedPasswordData
        }
        
        return password
    }
    
    func save(password: String, forKey key: String) throws {
        let encodedPassword = password.dataUsingEncoding(NSUTF8StringEncoding)!
        
        do {
            try _ = read(withKey: key)
            
            var attributesToUpdate = [String : AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedPassword
            
            let query = keychainQuery(withKey: key)
            let status = SecItemUpdate(query, attributesToUpdate)
            
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        }
        catch KeychainError.noPassword {
            var newItem = keychainQuery(withKey: key)
            newItem[kSecValueData as String] = encodedPassword
            
            let status = SecItemAdd(newItem, nil)
            
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        }
    }
    
    func deleteItem(withKey key: String) throws {
        let query = keychainQuery(withKey: key)
        let status = SecItemDelete(query)
        
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
    
    
}
