//
//  Date+.swift
//  mmDiary
//
//  Created by wxm on 2022/9/20.
//

import Foundation


//MARK: - date处理

extension Date {
    
    func getMonthName() -> String {
        let date = self
        let month = Calendar.current.component(.month, from: date)
        let months = ["January", "February", "March", "April", "May", "June",
                      "July", "August", "September", "October", "November", "December"]
        let monthName = months[month-1]
        return monthName
    }
    
    func getDayInWeek() -> String {
        let date = self
        let day = Calendar.current.component(.weekday, from: date)
        let days = ["Sun","Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        let monthName = days[day-1]
        return monthName
    }
    
}
