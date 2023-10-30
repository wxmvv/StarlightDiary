//
//  MyDatePicker.swift
//  mmDiary
//
//  Created by wxm on 2022/9/26.
//

import SwiftUI

struct MyDatePicker: View {
    
    public let months:[String] = ["January", "February", "March", "April", "May", "June",
                                  "July", "August", "September", "October", "November", "December"]
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    @State private var selectMon:String =  Date().getMonthName()
    @State private var selectMonInt:Int = 0
    @State private var selectYear:Int = (Int(dateFormatteryyyy.string(from: Date())) ?? 0)
    
    @Binding var selectDate:Date
    @Binding var isShowDatePicker:Bool
    @Binding var searchStr:String
    
    var body: some View {
        VStack{
            VStack(spacing: 0) {
                HStack(spacing:0){
                    Picker("Picker", selection: $selectMon){
                        ForEach(months, id: \.self ) { name in
                            Text(name)
                        }
                    }
                    .frame(width: 135,height: 150)
                    Picker("Picker", selection: $selectYear){
                        ForEach(2015...2030, id: \.self ) { year in
                            Text(String(year))
                        }
                    }
                    .frame(width: 135,height: 150)
                }
                .pickerStyle(.wheel)
                .labelsHidden()
                
                HStack(spacing:0){
                    Button {
                        selectDate = dateFormatteryyyyMMMM.date(from: String(selectYear)+selectMon) ?? Date()
                        searchStr = String(selectYear)+selectMon
                        withAnimation {
                            isShowDatePicker = false
                        }
                        
                    } label: {
                        Text("select")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(width: 270,height: 46)
                            .background(appHeartColor.SwiftUiColor.opacity(0.8))
                    }
                }
                .shadow(radius: 2)
            }
            .background(.ultraThinMaterial)
            .cornerRadius(24)
            .shadow(radius: 8)
        }
    }
}

struct MyDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        
        MyDatePicker(selectDate:.constant(Date()),isShowDatePicker: .constant(true),searchStr: .constant("hello"))
    }
}



