//
//  FontStyle.swift
//  mwDiary
//
//  Created by 萌萌 on 2023/3/5.
//

import SwiftUI


struct FontStyle : Identifiable {
    var id = UUID()
    var name:String{
        get {
            switch self.font {
            case .Default:
                return "Default"
            case .SmileySans:
                return "SmileySans"
            case .Mono:
                return "Mono"
            }
        }
    }
    var fontName:String {
        get {
            switch self.font {
            case .Default:
                return ""
            case .SmileySans:
                return "SmileySans-Oblique"
            case .Mono:
                return "Ubuntu Mono derivative Powerline"
            }
        }
    }
    var font:FontType
}


//
//public let fontstyles:[FontStyle]=[
//    FontStyle(name: "Default", fontName: ""),
//    FontStyle(name: "SmileySans", fontName: "SmileySans-Oblique"),
//    FontStyle(name: "Mono", fontName: "Ubuntu Mono derivative Powerline")
//]

enum FontType:String {
    case Default
    case SmileySans
    case Mono
    
    var bodyFont:Font{
        get {
            switch self {
            case .Default:
                return Font.system(size: 18)
            case .SmileySans:
                return Font.custom("SmileySans-Oblique", size: 18)
            case .Mono:
                return Font.custom("Ubuntu Mono derivative Powerline", size: 18)
            }
        }
    }
    var titleFont:Font {
        get {
            switch self {
            case .Default:
                return Font.system(size: 20,weight: .semibold)
            case .SmileySans:
                return Font.custom("SmileySans-Oblique", size: 20)
            case .Mono:
                return Font.custom("Ubuntu Mono derivative Powerline Bold", size: 20)
            }
        }
    }
    var titleUIFont:UIFont{
        get {
            switch self {
            case .Default:
                return UIFont.preferredFont(forTextStyle: .headline)
            case .SmileySans:
                return UIFont(name: "SmileySans-Oblique", size: 20) ?? UIFont.preferredFont(forTextStyle: .headline)
            case .Mono:
                return UIFont(name: "Ubuntu Mono derivative Powerline Bold", size: 20) ?? UIFont.preferredFont(forTextStyle: .headline)
                
            }
        }
    }
}
