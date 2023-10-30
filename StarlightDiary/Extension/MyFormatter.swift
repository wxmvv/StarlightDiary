//
//  Formatter.swift
//  mmDiary
//
//  Created by wxm on 2022/9/21.
//

import Foundation

//其他选项
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    short full medi long
//    yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'" z
//设置Formatter时区
//    formatter.timeZone = TimeZone(secondsFromGMT: 8)

var dateFormatterHHmm:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    formatter.locale = Locale(identifier: Locale.current.identifier)
    return formatter
}


var dateFormatterMMMddHHmm:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd HH:mm"
    formatter.locale = Locale(identifier: Locale.current.identifier)
    return formatter
}

var dateFormatterMMdd:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "M-dd"
    formatter.locale = Locale(identifier: Locale.current.identifier)
    return formatter
}

var dateFormatterMMMM:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    formatter.locale = Locale(identifier: Locale.current.identifier)
    return formatter
}

var dateFormatteryyyyMM:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMM"
    formatter.locale = Locale(identifier: Locale.current.identifier)
    return formatter
}

var dateFormatterMM:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM"
    formatter.locale = Locale(identifier: Locale.current.identifier)
    return formatter
}

var dateFormatterdd:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    formatter.locale = Locale(identifier: Locale.current.identifier)
    return formatter
}
var dateFormatteryyyy:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    formatter.locale = Locale(identifier: Locale.current.identifier)
    return formatter
}

var dateFormatteryyyyMMMM:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMMM"
    formatter.locale = Locale(identifier: Locale.current.identifier)
    return formatter
}

var dateFormatterHHmmss:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    formatter.locale = Locale(identifier: Locale.current.identifier)
    return formatter
}
var dateFormatteryyyyMMdd:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: Locale.current.identifier)
    return formatter
}


var exportDateFormatteryyyyMMddHHmmss:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd HHmmss"
    formatter.locale = Locale(identifier: Locale.current.identifier)
    return formatter
}
