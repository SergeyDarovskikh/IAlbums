//
//  SignUpCellViewModelProtocol.swift
//  IAlbums
//
//  Created by Сергей Даровских on 12.02.2022.
//

import Foundation

protocol SignUpCellViewModelProtocol {
    var cellType: SignUpCellType { get }
    var title: String { get }
    var value: String? { get }
    var errorClosure: ((String)->())? { get }
}

enum SignUpCellType {
    case text
    case date
}
