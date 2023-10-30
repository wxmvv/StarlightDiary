//
//  minimalStyleMoodCard.swift
//  mwDiary
//
//  Created by 萌萌 on 2023/3/14.
//

import SwiftUI

struct MinimalStyleMoodCard: View {
    var mymood:MoodType = .none
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    var body:some View{
        HStack{
            VStack(alignment: .leading,spacing: 10){
                Text(mymood.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity,alignment: .leading)
                Text(mymood.body)
                //                .lineLimit(3)
                    .font(.headline)
                    .frame(maxHeight: .infinity,alignment: .top)
            }
            .padding(20)
            .frame(minWidth: 300,maxWidth: 480,minHeight: 180,maxHeight: 280)
            .background(content: {
                appHeartColor.SwiftUiColor
                    .opacity(0.3)
            })
            .cornerRadius(20)
        }
        
        .padding(.vertical,12)
        .listRowSeparator(.hidden)
    }
}

struct minimalStyleMoodCard_Previews: PreviewProvider {
    static var previews: some View {
        MinimalStyleMoodCard()
    }
}
