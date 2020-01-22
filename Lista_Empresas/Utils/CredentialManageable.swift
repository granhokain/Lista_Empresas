//
//  CredentialManageable.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation
import KeychainSwift


public enum CredentialKey: String {
    case token
    case tokenCompany = "token-company"
    case refreshToken = "refresh-token"
}

public protocol CredentialManageable {
    func save(_ value: String, forKey: CredentialKey)
    func save(_ values: Data, forKey: CredentialKey)
    func removeItem(_ key: CredentialKey)
    func retrive(_ key: CredentialKey) -> String?
    func retriveData(_ key: CredentialKey) -> Data?
    func removeAll()
}

class CredentialManager: CredentialManageable {
    
    private let keychainSwiftIntance = KeychainSwift()
    
    func save(_ value: String, forKey: CredentialKey) {
        keychainSwiftIntance.set(value, forKey: forKey.rawValue)
    }
    
    func save(_ values: Data, forKey: CredentialKey) {
        keychainSwiftIntance.set(values, forKey: forKey.rawValue)
    }
    
    func removeItem(_ key: CredentialKey) {
        keychainSwiftIntance.delete(key.rawValue)
    }
    
    func retrive(_ key: CredentialKey) -> String? {
        return keychainSwiftIntance.get(key.rawValue)
    }
    
    func retriveData(_ key: CredentialKey) -> Data? {
        return keychainSwiftIntance.getData(key.rawValue)
    }
    
    func removeAll() {
        keychainSwiftIntance.clear()
    }
    
}
