//
//  HeartColor.swift
//  mwDiary
//
//  Created by wxm on 2022/9/28.
//

import SwiftUI

//MARK: - Heart Color
struct HeartColor:Identifiable {
    var id = UUID()
    var name:String {
        get {
            switch self.color{
            case .primary:
                return "default"
            case .blue:
                return "blue"
            case .yellow:
                return "yellow"
            case .red:
                return "red"
            case .cyan:
                return "cyan"
            }
        }
    }
    var color:HeartColorType
}

//MARK: - 在这里添加颜色
enum HeartColorType:String {
    case primary
    case yellow
    case red
    case blue
    case cyan
    
    var SwiftUiColor:Color {
        get {
            switch self{
            case .primary:
                return Color.primary
            case .blue:
                return Color(.systemBlue)
            case .yellow:
                return Color(.systemYellow)
            case .red:
                return Color(.systemRed)
            case .cyan:
                return Color(.systemCyan)
            }
        }
    }
}
