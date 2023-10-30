//
//  PreferenceKey.swift
//  mmDiary
//
//  Created by wxm on 2022/9/24.
//


import SwiftUI

struct TabPreferenceKey:PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct SearchPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct TitlePreferenceKey:PreferenceKey {
    //defaultValue
    static var defaultValue: String = ""
    //reduce
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}


struct IsSearchingPreferenceKey : PreferenceKey{
    static var defaultValue: Bool = false
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}
