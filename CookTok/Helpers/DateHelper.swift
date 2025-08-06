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
    
    
    // 날짜에 일수를 더하는 안전한 메서드
      static func addDays(to date: Date, days: Int) -> Date {
          return Calendar.current.date(byAdding: .day, value: days, to: date) ?? date
      }
    
    // 날짜에 일수를 더하고 포맷된 문자열로 반환
       static func convertDateWithOffset(inputDate: Date, daysOffset: Int) -> String {
           let adjustedDate = addDays(to: inputDate, days: daysOffset)
           return convertDate(inputDate: adjustedDate)
       }
    
}
