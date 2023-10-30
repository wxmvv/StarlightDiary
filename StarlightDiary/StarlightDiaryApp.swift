//
//  StarlightDiaryApp.swift
//  StarlightDiary
//
//  Created by 萌萌 on 2023/10/30.
//

import SwiftUI

@main
struct StarlightDiaryApp: App {
    @StateObject var diaryvm = DiaryViewMode()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(diaryvm)
        }
    }
}


//import SwiftUI
//
//@main
//struct mwDiaryApp: App {
//    @StateObject var diaryvm = DiaryViewMode()
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environmentObject(diaryvm)
//        }
//    }
//}
