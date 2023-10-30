//
//  SettingView.swift
//  StarlightDiary
//
//  Created by 萌萌 on 2023/10/30.
//

import SwiftUI

struct SettingView: View {
    
    @AppStorage("appTheme") var appTheme:ThemeType = .Automatic
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    @AppStorage("smallTitle") var smallTitle:Bool = false
    @EnvironmentObject var diaryvm:DiaryViewMode
    
    @AppStorage("isICloud") var isICloud:Bool = true
    
    @AppStorage("defaultTitle") var defaultTitle = "My daily mood"
    @AppStorage("defaultBody") var defaultBody = ""
    @AppStorage("showMoodCard") var showMoodCard = false
    @State var editTitle:String = ""
    @State var editText:String = ""
    
    @State var editMood:Bool = false
    @AppStorage("mymood") var mymood:MoodType = .none
    
    let mymoods:[MoodType] = [
        .happy,.boring,.sweet,.sad,.empty
    ]
    
    var body: some View {
        minimalSettingView
        // kakeSettingView
    }//body
    
//    var editMoodView :some View{
//        List{
//
//        }
//    }
    
    
    
    var minimalSettingView:some View{
        NavigationView {
            List{
                if showMoodCard {
                    if editMood{
                        ForEach(mymoods,id: \.self){mood in
                            MinimalStyleMoodCard(mymood: mood)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        mymood = mood
                                        editMood.toggle()
                                    }
                                }
                        }
                    }else{
                        MinimalStyleMoodCard(mymood: mymood)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    editMood.toggle()
                                }
                            }
                    }
                }
                NavigationLink {
                    AppearanceView()
                } label: {
                    Text("Appearance")//外观风格
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .leading)
                .padding(.horizontal,24)
                .background(Color.gray.opacity(0.1))
                Spacer()
                Button {
                    diaryvm.exportAllToCSV()
                } label: {
                    Text("Export Data")
                }.listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .frame( maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.horizontal,24)
                    .background(Color.gray.opacity(0.1))
                NavigationLink {
                    DefaultDiaryView(editTitle: $editTitle, editText: $editText)
                } label: {
                    Text("Default Diary")
                }.onAppear {
                    if defaultTitle != "My daily mood" && defaultTitle != "" {
                        editTitle = defaultTitle
                    }
                    if defaultBody != "" {
                        editText = defaultBody
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .frame( maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal,24)
                .background(Color.gray.opacity(0.1))
                Spacer()
                Link(destination: URL(string: "mailto:wxmvv@outlook.com")!, label: {Text("Contact")})
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .frame( maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.horizontal,24)
                    .background(Color.gray.opacity(0.1))
            }
            .tint(appHeartColor.SwiftUiColor)
            .listStyle(.plain)
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(smallTitle ? .inline:.large)
        }
//        .blur(radius: 20)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    
    //kake
    var kakeSettingView:some View{
        NavigationView {
            List{
                Section{
                    NavigationLink {
                        AppearanceView()
                    } label: {
                        Label("Appearance", systemImage: "paintpalette.fill")
                            .font(.subheadline)
                            .frame(height: 33)
                    }
                    Button {
                        diaryvm.exportAllToCSV()
                    } label: {
                        Label("Export Data", systemImage: "doc.circle.fill")
                            .font(.subheadline)
                            .frame(height: 33)
                    }
                    //TODO: - icloud
                    //                        Toggle(isOn: $isICloud) {
                    //                            Label("iCloud Sync", systemImage: "icloud.circle.fill")
                    //                                .font(.subheadline)
                    //                                .frame(height: 33)
                    //                        }
                    //                        .tint(appHeartColor.SwiftUiColor)
                } header:{
                    Text("GENERAL")
                }
                //TODO: - 内购
                //                    Section{
                //                        Label("Premium Features", systemImage: "crown")
                //                    } header:{
                //                    Text("PREMIUM")
                //                }
                //MARK: - defaultTitle
                Section {
                    NavigationLink {
                        DefaultDiaryView(editTitle: $editTitle, editText: $editText)
                    } label: {
                        Label("Default Diary", systemImage: "doc.text")
                            .font(.subheadline)
                            .frame(height: 33)
                    }.onAppear {
                        if defaultTitle != "My daily mood" && defaultTitle != "" {
                            editTitle = defaultTitle
                        }
                        if defaultBody != "" {
                            editText = defaultBody
                        }
                    }
                } header: {
                    Text("TEMPLATE")
                }
                Section{
                    Link(destination: URL(string: "mailto:wxmvv@outlook.com")!, label: {Label("Contact", systemImage: "link.circle.fill")})
                        .font(.subheadline)
                        .frame(height: 40)
                    //TODO: - 分享和评论 内购
                    //                        Link(destination: URL(string: "http://itunes.apple.com/cn/app/id6443545292")!, label: {Label("Rate App", systemImage: "star")})
                    //                        //http://itunes.apple.com/cn/app/id6443545292
                    //                        //https://itunes.apple.com/cn/app/id6443545292
                    //                        Label("Share", systemImage: "square.and.arrow.up")
                    //                        Label("Buy me a Coffee", systemImage: "cup.and.saucer")
                } header:{
                    Text("OTHERS")
                }
            }//list
            .tint(Color(.label))
            .labelStyle(.titleAndIcon)
            .listStyle(.plain)
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
        }//nav
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
}






struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
        //            .preferredColorScheme(.dark)
    }
}



