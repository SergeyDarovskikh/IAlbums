//
//  UserInfoViewModel.swift
//  IAlbums
//
//  Created by Сергей Даровских on 13.02.2022.
//

import UIKit

class UserInfoViewModel {
    private var cellsModelsArray = [UserInfoCellModel]()

    init() {
        setup()
    }
    
    private func setup() {
        guard let userModel = UserDefaultsManager.shared.activeUser else { return }
        cellsModelsArray.append(UserInfoCellModel(title: "Email", value: userModel.email))
        cellsModelsArray.append(UserInfoCellModel(title: "First Name", value: userModel.firstName))
        cellsModelsArray.append(UserInfoCellModel(title: "Second Name", value: userModel.secondName))
        cellsModelsArray.append(UserInfoCellModel(title: "Date of birth", value: userModel.birthday))
        cellsModelsArray.append(UserInfoCellModel(title: "Phone", value: userModel.phone))
    }
    
    func getHeightForRow(forIndexPath indexPath: IndexPath) -> CGFloat {
        return UserInfoCell.height
    }
    
    func getNumberOfRowsInSections() -> Int {
        return cellsModelsArray.count
    }
    
    func getModelForCell(atIndexPath indexPath: IndexPath) -> UserInfoCellModel? {
        return cellsModelsArray[indexPath.row]
    }
    
    func logOut() {
        UserDefaultsManager.shared.activeUser = nil
    }
}
