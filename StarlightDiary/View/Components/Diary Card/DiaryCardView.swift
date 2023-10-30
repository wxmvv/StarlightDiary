//
//  NoteCard.swift
//  ProgressBar
//
//  Created by wxm on 2022/9/6.
//

import SwiftUI

struct DiaryCardView: View {
    
    @ObservedObject var diary:DiaryEntity
    @AppStorage("cardLayout") var cardLayout:Int = 1
    @AppStorage("fontStyle") var fontStyleStr:FontType = .Default
    var isFirstDiaryOfDay = true
    
    var body: some View {
        DiaryCardLayOutView(e_create_date: diary.create_date ?? Date(), e_modified_date: diary.modified_date ?? Date(), e_title: diary.title ?? "i am title", e_body: diary.body ?? "i am body", e_isFav: diary.is_fav,layoutIndex: cardLayout,fontStyleString: fontStyleStr,isFirstDiaryOfDay: isFirstDiaryOfDay)
    }
}
