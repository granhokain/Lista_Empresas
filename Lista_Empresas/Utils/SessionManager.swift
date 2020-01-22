//
//  SessionManager.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

import Foundation
import WebKit

protocol SessionManageable {
    init(userDefaults: UserDefaults)
    func setUser(_ user: User)
    func setNotificationToken(_ notificationToken: String)
    func getNotificationToken() -> String
    func logout()
    func setFirstUse()
    func isLoggedIn() -> Bool
    func getUserId() -> String
    func isFirstUse() -> Bool
    func getUserDetail() -> UserPersistent?
}

class SessionManager: SessionManageable {
    
    private let userDefaults: UserDefaults!
    
    required init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func setUser(_ user: User) {
        userDefaults.set(true, forKey: Statics.UserDefaultsKeys.kUserIsLogeddIn)
        userDefaults.set(user.investor.id, forKey: Statics.UserDefaultsKeys.kUserId)
        let userPersistent = UserPersistent(user: user)
        let data = userPersistent.encode()
        userDefaults.set(data, forKey: Statics.UserDefaultsKeys.kUser)
    }
    
    func setNotificationToken(_ notificationToken: String) {
        userDefaults.set(notificationToken, forKey: Statics.UserDefaultsKeys.kDeviceToken)
    }
    func getNotificationToken() -> String {
        return userDefaults.string(forKey: Statics.UserDefaultsKeys.kDeviceToken) ?? ""
    }
    
    func logout() {
        userDefaults.set(false, forKey: Statics.UserDefaultsKeys.kUserIsLogeddIn)
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            for record in records {
                dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {
                    debugPrint("Deleted: " + record.displayName);
                })
            }
        }
    }
    
    func setFirstUse() {
        userDefaults.set(true, forKey: Statics.UserDefaultsKeys.kIsAlredyUsed)
    }
    
    func isLoggedIn() -> Bool {
        return userDefaults.bool(forKey: Statics.UserDefaultsKeys.kUserIsLogeddIn)
    }
    
    func getUserId() -> String {
        return userDefaults.string(forKey: Statics.UserDefaultsKeys.kUserId)!
    }
    
    func isFirstUse() -> Bool {
        return !userDefaults.bool(forKey: Statics.UserDefaultsKeys.kIsAlredyUsed)
    }
    
    func getUserDetail() -> UserPersistent? {
        let dataVinda = UserDefaults.standard.data(forKey: Statics.UserDefaultsKeys.kUser)
        return UserPersistent.decode(data: dataVinda)
    }
}
