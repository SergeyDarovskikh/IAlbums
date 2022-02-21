//
//  DateFormatHelper.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import Foundation

class DateFormatHelper {
    static func convertDateToString(date: Date, format: String = "dd.MM.yyyy") -> String? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        let dateString = dateFormater.string(from: date)
        return dateString
    }
    
    static func formatDateFromAPI(dateFirst: String) -> String {
        let dateBegin = DateFormatter()
        dateBegin.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let backDate = dateBegin.date(from: dateFirst) else { return " " }
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        let target = dateFormat.string(from: backDate)
        return target
    }
}
