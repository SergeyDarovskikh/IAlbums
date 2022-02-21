//
//  SignUpDateCellViewModel.swift
//  IAlbums
//
//  Created by Сергей Даровских on 12.02.2022.
//

import Foundation

class SignUpDateCellViewModel: SignUpCellViewModelProtocol {
    var cellType: SignUpCellType
    
    var title: String
    var errorClosure: ((String)->())?
    var value: String?
    
    init(cellType: SignUpCellType, title: String) {
        self.cellType = cellType
        self.title = title
    }
    
    func validate(value: Date) {
        let calendar = NSCalendar.current
        let dateNow = Date()
        let bithday = value

        let age = calendar.dateComponents([.year], from: bithday, to: dateNow)
        
        if let ageYear = age.year, ageYear >= 18 {
            errorClosure?("")
            self.value = DateFormatHelper.convertDateToString(date: value)
        } else {
            errorClosure?("Invalid date")
            self.value = nil
        }
    }
}
