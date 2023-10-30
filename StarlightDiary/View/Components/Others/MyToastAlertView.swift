//
//  ToastAlertView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/26.
//

import SwiftUI


struct MyToastAlertView:View {
    var icon:String = "heart"
    var text:String = "Add to Favs"
    var body: some View{
        VStack(spacing:10){
            Image(systemName:icon)
                .font(.title)
            Text(text)
                .font(.subheadline)
        }
        .foregroundColor(.primary)
        .padding(.horizontal,60)
        .padding(.vertical,28)
        .padding(.bottom,icon == "" ? 10 : 0)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
}


struct ToastAlertView_Previews: PreviewProvider {
    static var previews: some View {
        MyToastAlertView()
            .preferredColorScheme(.dark)
    }
}
