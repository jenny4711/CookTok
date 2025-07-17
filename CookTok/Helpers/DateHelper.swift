//
//  DateHelper.swift
//  CookTok
//
//  Created by Ji y LEE on 7/17/25.
//

import Foundation

struct DateHelper{
    static func convertDate(inputDate:Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        return df.string(from:inputDate)
    }
}
