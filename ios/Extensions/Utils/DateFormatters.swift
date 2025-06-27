//
//  File.swift
//  Runner
//
//  Created by GØDØFIMØ on 27/6/25.
//

import SwiftUI

func formatDate(_ entry: SimpleEntry) -> String {

    let date = entry.date
    let calendar = Calendar.current
    let month = calendar.component(.month, from: date)
    let formatter = DateFormatter()

    if month == 6 || month == 7 {
        formatter.dateFormat = "d MMMM"
    } else {
        formatter.dateFormat = "d MMM"
    }
    formatter.locale = Locale(identifier: "en_US")
    return formatter.string(from: date)
}


let formatter: DateFormatter = {
    let f = DateFormatter()
    f.dateFormat = "EEEE"
    return f
}()
