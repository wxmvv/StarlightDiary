//
//  JournalsView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/16.
//

import SwiftUI

//MARK: - JournalView
struct JournalView: View {
    
    @EnvironmentObject var diaryvm:DiaryViewMode
    @State var editTitle = ""
    @State var editText = ""
    @State var showEditView = false
    @State var showDeleteAlert:Bool = false
    //    private var navTitle = "Journals"
    @State var isShowFavToastAlert = false
    @State var isShowDeleteToastAlert = false
    @State var selectEntity:DiaryEntity? = nil
    
    //MARK: - filteredDiary
    var filteredDiary: [DiaryEntity] {
        if searchStr.isEmpty {
            return []
        } else {
            return diaryvm.coredata_diarys.filter{
                dateFormatterMM.string(from: $0.create_date!).localizedCaseInsensitiveContains(searchStr)
                || dateFormatterdd.string(from: $0.create_date!) == searchStr || dateFormatteryyyyMMMM.string(from: $0.create_date!) == searchStr
            }
        }
    }
    //MARK: - Search
    @State var isSearchingValue = false
    @State var searchStr = ""
    @State var searchDate:Date = Date()
    //MARK: - DatePicker
    @State var isShowDatePicker = false
    
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack{
                    DiaryListView(
                        editTitle: $editTitle,
                        editText: $editText,
                        showEditView: $showEditView,
                        showDeleteAlert: $showDeleteAlert,
                        selectEntity: $selectEntity,
                        isShowFavToastAlert: $isShowFavToastAlert,
                        isShowDeleteToastAlert: $isShowFavToastAlert,
                        filteredDiary: filteredDiary)
                    .onPreferenceChange(IsSearchingPreferenceKey.self) { value in
                        withAnimation (.easeInOut){
                            self.isSearchingValue = value
                        }
                    }
                }
                .searchable(text:$searchStr,prompt: "")
                .navigationTitle("Search")
            }
            .onTapGesture {withAnimation (.easeInOut){isShowDatePicker = false}}
            .navigationViewStyle(StackNavigationViewStyle())
            
            //MARK: - toolBar
            if !isSearchingValue {
                Button {
                    withAnimation {
                        isShowDatePicker = true
                    }
                } label: {
                    VStack{
                        Image(systemName: "calendar").font(.title)
                        //                        Text(dateFormatteryyyyMM.string(from: searchDate))
                    }
                }
                .frame(width: 50, height: 50)
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment:filteredDiary==[] ? .center : .topTrailing)
                .padding(.trailing,10)
                .padding(.top,40)
                .tint(Color(.label))
            }
            
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
            //MARK: - 弹窗datepicker
            if isShowDatePicker {
                MyDatePicker(selectDate: $searchDate,isShowDatePicker: $isShowDatePicker, searchStr: $searchStr)
                    .zIndex(1)
                
            }
        }
    }
}







//MARK: - 预览
struct JournalsView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
            .environmentObject(DiaryViewMode())
    }
}




