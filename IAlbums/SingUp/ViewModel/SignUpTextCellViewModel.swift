//
//  SignUpTextCellViewModel.swift
//  IAlbums
//
//  Created by Сергей Даровских on 12.02.2022.
//

import Foundation
import UIKit

class SignUpTextCellViewModel: SignUpCellViewModelProtocol {
    var cellType: SignUpCellType
    
    var title: String
    var fieldType: TextCellType
    var keyboardType: UIKeyboardType
    var errorClosure: ((String)->())?
    var value: String?
    
    init(cellType: SignUpCellType, title: String, fieldType: TextCellType, keyboardType: UIKeyboardType) {
        self.cellType = cellType
        self.title = title
        self.fieldType = fieldType
        self.keyboardType = keyboardType
    }
    
    enum TextCellType {
        case email
        case password
        case name
        case phone
    }
    
    func validate(value: String) {
        let format = "SELF MATCHES %@"
        switch fieldType {
        case .email:
            let regex = "[a-zA-z0-9]{1,30}+@[a-z]{1,30}+\\.[a-z]{2,6}"
            if NSPredicate(format: format, regex).evaluate(with: value) {
                self.value = value
                errorClosure?("")
            } else {
                self.value = nil
                errorClosure?("Email is invalid")
            }
        case .password:
            let regex = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}"
            if NSPredicate(format: format, regex).evaluate(with: value){
                self.value = value
                errorClosure?("")
            } else {
                self.value = nil
                errorClosure?("Password is invalid")
            }
        case .name:
            let regex = "[a-zA-z]{1,20}"
            if NSPredicate(format: format, regex).evaluate(with: value){
                self.value = value
                errorClosure?("")
            } else {
                self.value = nil
                errorClosure?("Name is invalid")
            }
        case .phone:
            if value.count == 18 {
                self.value = value
                errorClosure?("")
            } else {
                self.value = nil
                errorClosure?("Phone is invalid")
            }
        }
    }
}
