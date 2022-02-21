//
//  AuthorizationViewModel.swift
//  IAlbums
//
//  Created by Сергей Даровских on 12.02.2022.
//

import Foundation

class AuthorizationViewModel {
    func tryToSignIn(email: String, password: String) -> SignInResult {
        guard let user = findUser(email: email) else { return .error("User not found") }
        
        if user.password == password {
            return .success(user)
        } else {
            return .error("Wrong password")
        }
    }
    
    private func findUser(email: String) -> UserModel? {
        let dataBase = UserDefaultsManager.shared.users
        
        for user in dataBase {
            if user.email == email {
                return user
            }
        }
        return nil
    }
    
    enum SignInResult {
        case success(UserModel)
        case error(String)
    }
}
