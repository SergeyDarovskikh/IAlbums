//
//  UserModel.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import Foundation

struct UserModel: Codable {
    let firstName : String
    let secondName : String
    let password : String
    let email : String
    let phone : String
    let birthday : String
}
