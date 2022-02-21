//
//  UserDefaultsManager.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import Foundation

class UserDefaultsManager {

    static let shared = UserDefaultsManager()
    
    enum SettingsKeys: String {
        case users
        case activeUser
    }
    
    let defaults = UserDefaults.standard
    let userKey = SettingsKeys.users.rawValue
    let activeUserKey = SettingsKeys.activeUser.rawValue
    
    var users: [UserModel] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([UserModel].self, from: data)
            } else {
                return [UserModel]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    var activeUser: UserModel? {
        get {
            if let data = defaults.value(forKey: activeUserKey) as? Data {
                return try! PropertyListDecoder().decode(UserModel.self, from: data)
            } else {
                return nil
            }
        }
        set {
            let data = try? PropertyListEncoder().encode(newValue)
            defaults.set(data, forKey: activeUserKey)
        }
    }

    func saveUser(firstName: String, secondName: String, password: String, email: String, phone: String, age: String ) {
        let user = UserModel(firstName: firstName, secondName: secondName, password: password, email: email, phone: phone, birthday: age)
        users.insert(user, at: 0)
    }
    
    func saveActiveUser(user: UserModel) {
        activeUser = user
    }
}
