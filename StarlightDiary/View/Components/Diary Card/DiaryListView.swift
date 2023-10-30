//
//  DiaryListView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/23.
//

import SwiftUI


struct DiaryListView: View {
    
    @AppStorage("smallTitle") var smallTitle:Bool = false
    @EnvironmentObject var diaryvm:DiaryViewMode
    @Binding var editTitle:String
    @Binding var editText:String
    @Binding var showEditView:Bool
    @Binding var showDeleteAlert:Bool
    @State var ShowSaveAlert:Bool = false
    @Binding var selectEntity:DiaryEntity?
    @Binding var isShowFavToastAlert:Bool
    @Binding var isShowDeleteToastAlert:Bool
    var con:DiaryEntity? = nil
    var isfirst:Bool? = nil
    var isFirstList:[Bool] = {
        return []
    }()
    
    @AppStorage("defaultTitle") var defaultTitle = "My daily mood"
    @AppStorage("defaultBody") var defaultBody = ""
    
    @Environment(\.isSearching) var isSearching
    
    var filteredDiary : [DiaryEntity]
    
    
    
    var body: some View{
        List{
            
            ForEach(filteredDiary) { entity in
                
                DiaryCardView(diary: entity,isFirstDiaryOfDay: true)
                //MARK: - 设置卡片边距
                    .padding(.vertical,10)
                    .padding(.horizontal,18)
                //MARK: - 点击编辑
                    .onTapGesture {
                        showEditView = true
                        selectEntity = entity
                        editTitle = entity.title ?? ""
                        editText = entity.body ?? ""
                    }
                //MARK: - 滑动菜单
                    .swipeActions(edge: .trailing, allowsFullSwipe: false, content: {
                        //MARK: deleteButton
                        Button {
                            selectEntity = entity
                            showDeleteAlert.toggle()
                        } label: {
                            Image(systemName: "xmark").font(.title)
                        }
                        .tint(Color(.systemRed))
                        //MARK: FavButton
                        Button {
                            selectEntity = entity
                            withAnimation (.easeOut(duration: 1.1)){
                                diaryvm.favToggle(entity: entity)
                            }
                            isShowFavToastAlert = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5,execute: {
                                withAnimation (.easeInOut(duration: 0.2)){
                                    isShowFavToastAlert = false
                                    selectEntity = nil
                                }
                            })
                        } label: {
                            Image(systemName:entity.is_fav ? "heart.slash" : "heart.fill" ).font(.title)
                        }
                        .tint(Color(entity.is_fav ? .systemGray2 : .systemYellow))
                    })
                    .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
                        //MARK: EditButton
                        Button{
                            showEditView = true
                            selectEntity = entity
                            editTitle = entity.title ?? ""
                            editText = entity.body ?? ""
                        } label: {
                            Image(systemName: "square.and.pencil").font(.title)
                            
                        }
                        .tint(Color(.systemBlue))})
            }//foreach
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            
            //在iOS15中 safe问题解决方法
            Spacer().listRowSeparator(.hidden)
//                .listRowInsets(EdgeInsets())
            
        }//list
        .listStyle(.plain)
        .preference(key: IsSearchingPreferenceKey.self, value: isSearching)
        .navigationBarTitleDisplayMode(smallTitle ? .inline:.large)
        //MARK: - Delete Alert
        .confirmationDialog(Text("You are deleting this journal:\n\(selectEntity?.title ?? "no title")"), isPresented: $showDeleteAlert, titleVisibility: .visible, actions: {
            Button("delete",role: .destructive){
                withAnimation(.easeInOut(duration: 0.5)){
                    diaryvm.deleteDiaryWithEntity(entity: selectEntity!)}
                selectEntity = nil
                isShowDeleteToastAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5,execute: {
                    withAnimation (.easeInOut(duration: 0.2)){
                        isShowDeleteToastAlert = false
                    }
                })
            }
        }, message: {Text("Are you sure?")})
        //MARK: - 保存提示
        .confirmationDialog(Text("Your diary Modified"), isPresented: $ShowSaveAlert, titleVisibility: .visible, actions: {
            Button("save",role: .destructive){
                withAnimation(.easeInOut(duration: 0.5)){
                    if selectEntity == nil {
                        diaryvm.addDiary(titlestr: editTitle.isEmpty ? defaultTitle : editTitle, bodystr: editText.isEmpty ? defaultBody : editText)
                    } else {
                        diaryvm.updateDiary(titlestr: editTitle.isEmpty ? defaultTitle : editTitle, bodystr: editText.isEmpty ? "" : editText, entity: selectEntity)
                    }
                    editTitle = ""
                    editText = ""
                    selectEntity = nil
                }
            }
            Button("dismiss", role: .cancel) {
                editTitle = ""
                editText = ""
                selectEntity = nil
            }
            
        }, message: {Text("Save the Modified date?")})
        //MARK: - EditView
        .sheet(isPresented: $showEditView,onDismiss: {
            if selectEntity == nil  {
                if editText == "" && editTitle == "" {
                } else {
                    ShowSaveAlert = true
                }
            } else if selectEntity != nil && selectEntity?.title == editTitle && selectEntity?.body == editText {
            } else {
                ShowSaveAlert = true
            }
        }, content: {
            DiaryEditView(editTitle: $editTitle, editText: $editText, showEditView: $showEditView, selectEntity: $selectEntity)
        })
        
    }
}






