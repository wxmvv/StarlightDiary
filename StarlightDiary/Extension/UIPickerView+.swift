//
//  UIPickerView+.swift
//  mmDiary
//
//  Created by wxm on 2022/9/26.
//

import SwiftUI


//解决两个picker并排会重叠问题
//https://stackoverflow.com/questions/56961550/swiftui-placing-two-pickers-side-by-side-in-hstack-does-not-resize-pickers
extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric , height: 150)
    }
}
