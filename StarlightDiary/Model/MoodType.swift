//
//  MoodType.swift
//  mwDiary
//
//  Created by wxm on 2022/10/7.
//

import Foundation



enum MoodType:String{
    
    case none
    case happy
    case sad
    case boring
    case sweet
    case empty
    
    var title:String {
        get{
            switch self {
            case .none:
                return "Mood Card"
            case .happy:
                return "Happy"
            case .sad:
                return "Sad"
            case .boring:
                return "Boring"
            case .sweet:
                return "Sweet"
            case .empty:
                return "Empty"
                    
            }
        }
    }
    var body:String {
        get{
            switch self {
            case .none:
                return "Tap to select Mood."
            case .happy:
                return "Happy Today"
            case .sad:
                return "Sad 😢"
            case .boring:
                return "Boring 🥱"
            case .sweet:
                return "Sweet sweet sugar！"
            case .empty:
                return "Empty 🧘"
                    
            }
        }
    }
    
}


