//
//  BlankButtonStyle.swift
//  mwDiary
//
//  Created by wxm on 2022/9/27.
//

import SwiftUI


struct BlankButtonStyle:ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}


struct NormalButtonStyle:ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.gray.opacity(0.5) : Color.gray)
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
    }
}

