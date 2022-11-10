//
//  Userdefault.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/08.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let storage: UserDefaults

    var wrappedValue: T {
        get { self.storage.object(forKey: self.key) as? T ?? self.defaultValue }
        set { self.storage.set(newValue, forKey: self.key) }
    }
    
    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
}

class UserManager {
    @UserDefault(key: "fcmToken", defaultValue: nil)
    static var fcmToken: String?
    
    @UserDefault(key: "authVerificationID", defaultValue: nil)
    static var authVerificationID: String?
    
    @UserDefault(key: "first", defaultValue: false)
    static var first: Bool
    
    @UserDefault(key: "phoneNumber", defaultValue: nil)
    static var phoneNumber: String?
    
    @UserDefault(key: "authVerificationToken", defaultValue: nil)
    static var authVerificationToken: String?
    
    @UserDefault(key: "certificationCode", defaultValue: nil)
    static var certificationCode: Int?
    
    @UserDefault(key: "nickname", defaultValue: nil)
    static var nickname: String?
    
    @UserDefault(key: "birth", defaultValue: nil)
    static var birth: String?
    
    @UserDefault(key: "email", defaultValue: nil)
    static var email: String?
    
    @UserDefault(key: "gender", defaultValue: nil)
    static var gender: Int?
}
