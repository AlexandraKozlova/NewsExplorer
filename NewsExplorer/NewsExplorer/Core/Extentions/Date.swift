//
//  Date.swift
//  NewsExplorer
//
//  Created by Aleksandra on 05.10.2023.
//

import Foundation

extension Date {
    init(dateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: dateString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    func formattedDateTo(format: DateFormatters) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}
