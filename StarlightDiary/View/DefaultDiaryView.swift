//
//  DefaultDiaryView.swift
//  mwDiary
//
//  Created by wxm on 2022/9/29.
//

import SwiftUI

struct DefaultDiaryView: View {
    
    @State private var beginEditTitle = false
    //    @EnvironmentObject var diaryvm:DiaryViewMode
    @Binding var editTitle:String
    @Binding var editText:String
    @State var isShowSaveAlert:Bool = false
    @State var isShowAnime:Bool = true
    @FocusState var isInputActive: Bool
    //
    @AppStorage("defaultTitle") var defaultTitle = "My daily mood"
    @AppStorage("defaultBody") var defaultBody = ""
    @AppStorage("appTheme") var appTheme:ThemeType = .Automatic
    @AppStorage("fontStyle") var fontStyleStr:FontType = .Default
    
    var body: some View{
        ZStack {
            //            NavigationView {
            VStack{
                Group{
                    //MARK: - 输入框
                    Rectangle()
                        .frame(height: 60)
                        .foregroundColor(Color.clear)
                    MyTextFieldWithUIKit(text: $editTitle, placeholder: "Input your default title", titleUIFont: fontStyleStr.titleUIFont, isFirstResponder: $beginEditTitle)
                    
                        .frame(height: 56,alignment: .center)
                        .overlay( RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(.primary, lineWidth: 3)
                        )
                        .padding(.top,20)
                    TextEditor(text: $editText)
                        .frame(height: 220)
                        .focused($isInputActive)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                HStack {
                                    Button {
                                        editText += " "+dateFormatterHHmmss.string(from: Date())
                                    } label: {
                                        Image(systemName: "clock")
                                    }
                                    Button {
                                        editText += " "+dateFormatteryyyyMMdd.string(from: Date())
                                    } label: {
                                        Image(systemName: "calendar")
                                    }
                                    Button {
                                        isInputActive = false
                                    } label: {
                                        Image(systemName: "keyboard.chevron.compact.down")
                                    }
                                }
                            }
                        }
                    
                        .autocorrectionDisabled(true)
                        .overlay( RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(.primary, lineWidth: 4)
                        )
                        .cornerRadius(10)
                    HStack{
                        Spacer()
                        //MARK: Save
                        Button {
                            defaultTitle = editTitle
                            defaultBody = editText
                            isShowSaveAlert = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5,execute: {
                                withAnimation (.easeInOut(duration: 0.2)){
                                    isShowSaveAlert = false
                                }
                            })
                        } label: {
                            Text("save")
                                .foregroundColor(appTheme.fontColor2)
                                .frame(width:60,height:35)
                                .background(appTheme.backColor2)
                        }
                    }
                }
                Text("Input your default title and body")
                    .font(.subheadline)
                Spacer()
                
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            //            }//nav
            //            .navigationViewStyle(StackNavigationViewStyle())
            if isShowSaveAlert {
//                ToastAlertView(icon: "",text: "Saved Default Diary").zIndex(1)
                MyToastAlertView(icon: "",text: "OK！").zIndex(1)
            }
            
        }
        
    }
    
}

struct DefaultDiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultDiaryView(editTitle: .constant("hello"), editText: .constant("abc"))
        //            .colorScheme(.dark)
    }
}
