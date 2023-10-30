//
//  AppearanceView.swift
//  StarlightDiary
//
//  Created by 萌萌 on 2023/10/30.
//

import SwiftUI

struct AppearanceView: View {
    
    @AppStorage("appTheme") var appTheme:ThemeType = .Automatic
    @AppStorage("fontStyle") var fontStyleStr:FontType = .Default
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    @AppStorage("cardLayout") var cardLayout:Int = 1
    @AppStorage("smallTitle") var smallTitle:Bool = false
    @AppStorage("showMoodCard") var showMoodCard:Bool = false
    @EnvironmentObject var diaryvm:DiaryViewMode
    
    private let themes:[Theme] = [
        Theme(theme: .Automatic),
        Theme(theme: .Light),
        Theme(theme: .Dark)
        //        Theme(theme: .rainbow)
    ]
    public let fontstyles:[FontStyle] = [
        FontStyle(font: .Default),
        FontStyle(font: .SmileySans),
        FontStyle(font: .Mono)
    ]
    private let icons:[AppIcon] = [
        AppIcon(iconName: nil, logoName: "icon 1"),
        AppIcon(iconName: "AppIcon 2", logoName: "icon 2"),
        AppIcon(iconName: "AppIcon 3", logoName: "icon 3"),
        AppIcon(iconName: "AppIcon 4", logoName: "icon 4"),
        AppIcon(iconName: "AppIcon 5", logoName: "icon 5"),
    ]
    private let heartColors:[HeartColor] = [
        HeartColor(color: .primary),
        HeartColor(color: .yellow),
        HeartColor(color: .red),
        HeartColor(color: .blue),
        HeartColor(color: .cyan)
    ]
    
    
    var body: some View {
        List{
            Group{
                //MARK: - change Theme
                Section {
                    themesCell
                } header: {
                    Text("THEMES")
                }
                //MARK: - change font style
                Section{
                    fontStyleCell
                } header: {
                    Text("FONT STYLE")
                }
                //MARK: - change app icon
                Section{
                    appIconCell
                } header: {
                    Text("APP ICON")
                }
            }
            Group{
                //MARK: - change favcolor
                Section{
                    favourateColorCell
                } header: {
                    Text("FAV COLOR")
                }
                //MARK: - change LAYOUT
                Section{
                    layoutCell
                } header: {
                    Text("LAYOUT")
                }
                Section{
                    //MARK: - change small title
                    Toggle(isOn: $smallTitle) {
                        smallTitleCell
                    }
                    //                    Toggle(isOn: $showMoodCard) {
                    //                        moodCardCell
                    //                    }
                } header: {
                    Text("MORE")
                }
                Group{
                    Spacer()
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
        }//list
        .listStyle(.plain)
        .navigationTitle("Appearance")
    }
    
    
    //MARK: Componts
    var themesCell:some View{
        VStack(alignment:.leading,spacing: 0){
            ForEach(themes) { theme in
                HStack{
                    theme.theme.swiftUILabel
                    Spacer()
                    Image(systemName: "checkmark")
                        .opacity(appTheme == theme.theme ? 1 : 0)
                }
                .padding()
                //MARK: 添加无色背景 用于点击
                .background(Color(.systemBackground).opacity(0.01))
                .onTapGesture {
                    withAnimation(.easeOut) {
                        appTheme = theme.theme
                    }
                }
            }
        }
    }
    var fontStyleCell:some View{
        ScrollView(.horizontal,showsIndicators:false){
            HStack(spacing:0){
                ForEach(fontstyles) { fs in
                    Button {
                        withAnimation(.linear,{
                            fontStyleStr = fs.font
                        })
                    } label: {
                        VStack(spacing: 8){
                            Text("Hell0!")
                                .font(.custom(fs.fontName,size:20))
                                .tint(fontStyleStr == fs.font ? appHeartColor.SwiftUiColor: Color.primary)
                            Text(fs.name)
                                .font(Font.callout)
                                .tint(Color.gray)
                        }
                        .overlay(content: {
                            Rectangle()
                                .foregroundColor(fontStyleStr == fs.font ? appHeartColor.SwiftUiColor.opacity(0.1) : Color(.systemBackground).opacity(0))
                                .cornerRadius(15)
                                .scaleEffect(1.3)
                        })
                        .padding(.trailing,20)
                    }
                }
            }
            .padding()
        }
    }
    var appIconCell:some View{
        ScrollView(.horizontal){
            HStack{
                ForEach(icons){ icon in
                    Button {
                        //MARK: 设置icon
                        UIApplication.shared.setAlternateIconName(icon.iconName)
                    } label: {
                        Image(icon.logoName)
                            .resizable()
                            .frame(width: 88, height: 88)
                            .cornerRadius(20)
                            .padding()
                    }
                }
            }
        }
    }
    var favourateColorCell:some View{
        ScrollView(.horizontal,showsIndicators:false){
            HStack(spacing:0){
                ForEach(heartColors){ item in
                    Button {
                        appHeartColor = item.color
                    } label: {
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .foregroundColor(item.color.SwiftUiColor)
                            .frame(width: 45, height: 45)
                            .cornerRadius(20)
                            .padding(.vertical)
                            .padding(.horizontal,15)
                            .overlay{
                                if item.color == appHeartColor {
                                    item.color.SwiftUiColor
                                        .frame(height:5)
                                        .frame(maxHeight:.infinity,alignment:.bottom)
                                }
                            }
                    }
                }
            }
        }
    }
    
    //TODO: show editDetail
    var layoutCell:some View{
        VStack(spacing:18){
            ForEach(1...4, id: \.self) { i in
                DiaryCardLayOutView(e_isFav:i == cardLayout ? true : false,layoutIndex:i,fontStyleString:fontStyleStr,settingView:true)
                    .onTapGesture {
                        cardLayout = i
                    }
            }
        }
    }
    var smallTitleCell:some View{
        VStack(alignment:.leading,spacing: 4){
            Text("Small Title").font(.headline)
            Text("Title style above every page").font(.callout).foregroundColor(Color.gray)
        }
        .padding(.vertical,2)
    }
    var moodCardCell:some View{
        VStack(alignment:.leading,spacing: 4){
            Text("Show Mood Card").font(.headline)
            Text("Mood Card in SettingView").font(.callout).foregroundColor(Color.gray)
        }
        .padding(.vertical,2)
    }
}//View




struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
            .environmentObject(DiaryViewMode())
            .preferredColorScheme(.light)
    }
}

