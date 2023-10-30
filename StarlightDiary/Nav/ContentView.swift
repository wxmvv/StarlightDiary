//
//  ContentView.swift
//  StarlightDiary
//
//  Created by 萌萌 on 2023/10/30.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("appTheme") var appTheme:ThemeType = .Automatic
    @State var selectTab:Tab = .diary
    @State var selectView:Tab = .diary

    var body: some View {
        ZStack{
            Group{
                switch selectView{
                case .diary:
                    DiaryView()
                case .journals:
                    JournalView()
                case .favs:
                    FavView()
                case .setting:
                    SettingView()
                }
            }
            .zIndex(0)
//            .safeAreaInset(edge: .bottom, spacing: 50) {Color.white.frame(height: 100)}
//            .ignoresSafeArea()
            .preferredColorScheme(appTheme.SystemColorScheme)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            MyTabView(selectTab: $selectTab,selectView: $selectView).zIndex(1)
                
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(DiaryViewMode())
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(DiaryViewMode())
//    }
//}


