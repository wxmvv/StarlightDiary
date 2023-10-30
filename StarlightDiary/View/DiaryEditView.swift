//
//  NoteEditView.swift
//  ProgressBar
//
//  Created by wxm on 2022/9/5.
//

import SwiftUI

struct DiaryEditView: View {
    @State private var beginEditTitle = false
    
    @EnvironmentObject var diaryvm:DiaryViewMode
    
    @Binding var editTitle:String
    @Binding var editText:String
    @Binding var showEditView:Bool
    @Binding var selectEntity:DiaryEntity?
    
    @FocusState var isInputActive: Bool
    
    @AppStorage("defaultTitle") var defaultTitle = "My daily mood"
    @AppStorage("defaultBody") var defaultBody = ""
    @AppStorage("fontStyle") var fontStyleStr:FontType = .Default
    
    var body: some View{
        NavigationView {
            VStack{
                Group{
                    //MARK: - 输入框
                    MyTextFieldWithUIKit(text: $editTitle, placeholder: defaultTitle, titleUIFont: fontStyleStr.titleUIFont, isFirstResponder: $beginEditTitle)
                    //                            .font(fontStyleStr.titleFont)
                        .frame(height: 56,alignment: .center)
                        .overlay( RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(.primary, lineWidth: 3)
                        )
                        .padding(.top,20)
                    TextEditor(text: $editText)
                        .focused($isInputActive)
                        .font(fontStyleStr.bodyFont)
                    //MARK: - 键盘按键定制
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                HStack {
                                    Button {
                                        editText += defaultBody
                                    } label: {
                                        Image(systemName: "doc.text")
                                    }
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
                                    Spacer()
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
                        if selectEntity?.modified_date != selectEntity?.create_date {
                            Text("Modified "+dateFormatterMMMddHHmm.string(from: selectEntity?.modified_date ?? Date()))
                                .font(.footnote)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }
                        Spacer()
                        //MARK: Save
                        Button {
                            //                    guard !editText.isEmpty else { return }
                            if selectEntity == nil {
                                diaryvm.addDiary(titlestr: editTitle.isEmpty ? defaultTitle : editTitle, bodystr: editText.isEmpty ? defaultBody : editText)
                            } else {
                                diaryvm.updateDiary(titlestr: editTitle.isEmpty ? defaultTitle : editTitle, bodystr: editText.isEmpty ? "" : editText, entity: selectEntity)
                            }
                            editTitle = ""
                            editText = ""
                            showEditView = false
                            selectEntity = nil
                        } label: {
                            Text("save")
                                .foregroundColor(Color(.systemBackground))
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}



