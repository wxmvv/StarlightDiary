//
//  NotePage.swift
//  StarlightDiary
//
//  Created by 萌萌 on 2023/10/30.
//

import SwiftUI

//MARK: - DiaryView
struct DiaryView: View {
    
    @EnvironmentObject var diaryvm:DiaryViewMode
    @State var editTitle = ""
    @State var editText = ""
    @State var showEditView = false
    @State var showDeleteAlert:Bool = false
    private var navTitle = dateFormatterMMMM.string(from:Date())
    @State var isShowFavToastAlert = false
    @State var isShowDeleteToastAlert = false
    @State var selectEntity:DiaryEntity? = nil
    
    //MARK: - filteredDiary
    var filteredDiary: [DiaryEntity] {
        if navTitle.isEmpty {
            return diaryvm.coredata_diarys
        } else {
            let a = diaryvm.coredata_diarys.filter { dateFormatterMMMM.string(from: $0.create_date!) == navTitle }
            return a.sorted { a, b in
                return a.create_date! > b.create_date!
            }
        }
    }
    
    
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    DiaryListView(editTitle: $editTitle,
                                  editText: $editText,
                                  showEditView: $showEditView,
                                  showDeleteAlert: $showDeleteAlert,
                                  selectEntity: $selectEntity,
                                  isShowFavToastAlert: $isShowFavToastAlert,
                                  isShowDeleteToastAlert: $isShowDeleteToastAlert,
                                  filteredDiary: filteredDiary)
                }
                .navigationTitle(navTitle)
                //MARK: - 下拉编辑
                .refreshable {
                    editTitle = ""
                    editText = ""
                    showEditView.toggle()
                }
            }//Nav
            .navigationViewStyle(StackNavigationViewStyle())
            
            //MARK: - toolBar
            Button {
                //TODO: - 储存默认值
                editTitle = ""
                editText = ""
                showEditView.toggle()
            } label: {
                Image(systemName: "pencil").font(.title)
            }
            .frame(width: 50, height: 50)
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment:filteredDiary==[] ? .center : .topTrailing)
            .padding(.trailing,10)
            .padding(.top,40)
            .tint(Color(.label))
            
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
        }//ZStack
        .tint(Color(.label))
    }//View
}




//MARK: - 预览
struct NotePage_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
            .environmentObject(DiaryViewMode())
    }
}


