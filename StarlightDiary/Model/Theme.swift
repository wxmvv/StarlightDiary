//
//  Themes.swift
//  mwDiary
//
//  Created by wxm on 2022/9/27.
//

import Foundation
import SwiftUI


//MARK: - Theme

struct Theme : Identifiable{
    var id = UUID()
    var name:String {
        switch self.theme {
        case .Automatic:
            return "Automatic"
        case .Light:
            return "Light"
        case .Dark:
            return "Dark"
        case .rainbow:
            return "Rainbow"
        }
    }
    var icon:String {
        switch self.theme {
        case .Automatic:
            return "sparkles"
        case .Light:
            return "sun.max"
        case .Dark:
            return "moon"
        case .rainbow:
            return "rainbow"
        }
    }
    
    var theme:ThemeType
    
}


enum ThemeType:String{
    case Automatic
    case Light
    case Dark
    case rainbow
    
    var swiftUILabel : some View {
        get {
            switch self {
            case .Automatic:
                return Label("Automatic", systemImage: "sparkles")
            case .Light:
                return Label("Light", systemImage: "sun.max")
            case .Dark:
                return Label("Dark", systemImage: "moon")
            case .rainbow:
                return Label("rainbow", systemImage: "rainbow")
            }
        }
    }
    
    var SystemColorScheme:ColorScheme? {
        get {
            switch self {
            case .Automatic:
                return nil
            case .Light:
                return ColorScheme.light
            case .Dark:
                return ColorScheme.dark
            case .rainbow:
                return ColorScheme.light
            }
        }
    }
    
    //基于系统哪个主题
    
    var fontColor:Color {
        get {
            switch self {
            case .Automatic:
                return Color(.label)
            case .Light:
                return Color(.label)
            case .Dark:
                return Color(.label)
            case .rainbow:
                return Color(.label)
            }
        }
    }
    var fontColor2:Color {
        get {
            switch self {
            case .Automatic:
                return Color("texteditorback")
            case .Light:
                return Color("texteditorback")
            case .Dark:
                return Color("texteditorback")
            case .rainbow:
                return Color("texteditorback")
            }
        }
    }
    
    
    //systemBackground secondarySystemBackground tertiarySystemBackground
    //https://sarunw.com/posts/dark-color-cheat-sheet/
    var backColor:Color {
        get {
            switch self {
            case .Automatic:
                return Color("texteditorback")
            case .Light:
                return Color("texteditorback")
            case .Dark:
                return Color("texteditorback")
            case .rainbow:
                return Color("texteditorback")
            }
        }
    }
    var backColor2:Color {
        get {
            switch self {
            case .Automatic:
                return Color("upcalback")
            case .Light:
                return Color("upcalback")
            case .Dark:
                return Color("upcalback")
            case .rainbow:
                return Color("upcalback")
            }
        }
    }
    var backColor3:Color {
        get {
            switch self {
            case .Automatic:
                return Color("downcalback")
            case .Light:
                return Color("downcalback")
            case .Dark:
                return Color("downcalback")
            case .rainbow:
                return Color("downcalback")
            }
        }
    }
    var sysBack:Color {
        get {
            switch self {
            case .Automatic:
                return Color(.systemBackground)
            case .Light:
                return Color(.systemBackground)
            case .Dark:
                return Color(.systemBackground)
            case .rainbow:
                return Color(.systemBackground)
            }
        }
    }
    
    
}



