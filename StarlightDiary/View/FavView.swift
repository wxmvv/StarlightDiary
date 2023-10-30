//
//  FavsView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/16.
//

import SwiftUI

struct FavView: View {
    
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    @EnvironmentObject var diaryvm:DiaryViewMode
    @State var editTitle = ""
    @State var editText = ""
    @State var showEditView = false
    @State var showDeleteAlert:Bool = false
    @State var isShowFavToastAlert = false
    @State var isShowDeleteToastAlert = false
    @State var selectEntity:DiaryEntity? = nil
    
    //MARK: - filteredDiary
    var filteredDiary: [DiaryEntity] {
        if searchStr.isEmpty {
            return diaryvm.coredata_diarys.filter{ $0.is_fav == true }
        } else {
            return diaryvm.coredata_diarys.filter { $0.is_fav == true && $0.title!.localizedCaseInsensitiveContains(searchStr) }
        }
    }
    //MARK: - search
    @State var searchStr = ""
    @State var isSearchingValue = false
    //MARK: - lottie
    @State var isShowAnime = false
    
    
    var body: some View {
        ZStack{
            NavigationView {
                VStack{
                    DiaryListView(editTitle: $editTitle,
                                  editText: $editText,
                                  showEditView: $showEditView,
                                  showDeleteAlert: $showDeleteAlert,
                                  selectEntity: $selectEntity,
                                  isShowFavToastAlert: $isShowFavToastAlert,
                                  isShowDeleteToastAlert: $isShowDeleteToastAlert,
                                  filteredDiary: filteredDiary)
                    .onPreferenceChange(IsSearchingPreferenceKey.self) { value in
                        withAnimation (.easeInOut){
                            self.isSearchingValue = value
                        }
                    }
                }
                //MARK: -搜索
                .searchable(text: $searchStr,prompt: "")
                //TODO: - 搜索后保留结果 取消focus
                //                .onSubmit(of: .search) { print("hello") }
                //MARK: - listStyle NavTitle
                .navigationTitle("Favourates")
            }//Nav
            .navigationViewStyle(StackNavigationViewStyle())
            
            //MARK: - toolBar
            if !isSearchingValue {
                Button {
                    isShowAnime = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3,execute: {
                        withAnimation (.easeInOut(duration: 0.2)){
                            isShowAnime = false
                        }
                    })
                } label: {
                    VStack{
                        Image(systemName: "heart.fill")
                            .font(filteredDiary==[] ? .title:.headline)
                    }
                }
                .frame(width: 50, height: 50)
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment:filteredDiary==[] ? .center : .topTrailing)
                .padding(.trailing,10)
                .padding(.top,40)
                .tint(appHeartColor.SwiftUiColor)
            }
            //MARK: - Lottie
            //            if isShowAnime {
            //                MyLottieVIew(animationName: "heart5", isPlaying: $isShowAnime)
            //                    .frame(width: 80,height: 80)
            //                    .offset(x:-5)
            //            }
            
            //MARK: - 弹窗
            if isShowFavToastAlert {
                if selectEntity?.is_fav == true {
                    MyToastAlertView(icon: "heart",text: "Add to Favs").zIndex(1)
                } else {
                    MyToastAlertView(icon: "heart.slash",text: "Remove from Favs").zIndex(1)
                }
            }
            
            if isShowDeleteToastAlert {
                MyToastAlertView(icon: "",text: "Diary deleted").zIndex(1)
            }
        }
    }
}


struct FavsView_Previews: PreviewProvider {
    static var previews: some View {
        FavView()
            .environmentObject(DiaryViewMode())
    }
}


