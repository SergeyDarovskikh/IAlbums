//
//  SignUpViewModel.swift
//  IAlbums
//
//  Created by Сергей Даровских on 12.02.2022.
//

import UIKit

class SignUpViewModel {
    private var cellsArray = [SignUpCellViewModelProtocol]()
    
    init() {
        setup()
    }
    
    private func setup() {
        cellsArray.append(SignUpTextCellViewModel(cellType: .text, title: "Email", fieldType: .email, keyboardType: .emailAddress))
        cellsArray.append(SignUpTextCellViewModel(cellType: .text, title: "Password", fieldType: .password, keyboardType: .default))
        cellsArray.append(SignUpTextCellViewModel(cellType: .text, title: "First Name", fieldType: .name, keyboardType: .default))
        cellsArray.append(SignUpTextCellViewModel(cellType: .text, title: "Second Name", fieldType: .name, keyboardType: .default))
        cellsArray.append(SignUpDateCellViewModel(cellType: .date, title: "Date of birth"))
        cellsArray.append(SignUpTextCellViewModel(cellType: .text, title: "Phone", fieldType: .phone, keyboardType: .numberPad))
    }
    
    func getCellType(indexPath: IndexPath) -> SignUpCellType {
        return cellsArray[indexPath.row].cellType
    }
    
    func getHeightForRow(forIndexPath indexPath: IndexPath) -> CGFloat {
        return SignUpTextCell.height
    }
    
    func getNumberOfRowsInSections() -> Int {
        return cellsArray.count
    }
    
    func getViewModelForCell(atIndexPath indexPath: IndexPath) -> SignUpCellViewModelProtocol? {
        return cellsArray[indexPath.row]
    }
    
    func trySignUp() -> Bool {
        if isDataValid() {
            UserDefaultsManager.shared.saveUser(firstName: cellsArray[2].value ?? "",
                                                secondName: cellsArray[3].value ?? "",
                                                password: cellsArray[1].value ?? "",
                                                email: cellsArray[0].value ?? "",
                                                phone: cellsArray[5].value ?? "",
                                                age: cellsArray[4].value ?? "")
            return true
        } else {
            return false
        }
    }
    
    private func isDataValid() -> Bool {
        for viewModel in cellsArray {
            return viewModel.value != nil ? true : false
        }
        return false
    }
}
