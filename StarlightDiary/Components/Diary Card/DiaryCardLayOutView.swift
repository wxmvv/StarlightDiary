//
//  ShowLayoutView.swift
//  mmDiary
//
//  Created by wxm on 2022/9/23.
//

import SwiftUI

struct DiaryCardLayOutView: View {
    //MARK: - Appearance
    @AppStorage("appTheme") var appTheme:ThemeType = .Automatic
    @AppStorage("heartColor") var appHeartColor:HeartColorType = .yellow
    //    @AppStorage("fontStyle") var fontStyleStr:FontType = .Default
    //    @ObservedObject var diary:DiaryEntity
    
    var e_create_date:Date = Date()
    var e_modified_date:Date = Date()
    var e_title:String = "I am title!"
    var e_body:String = "This is a preview window, tap to change the list layout ."
    var e_isFav:Bool = true
    var layoutIndex:Int = 1
    var fontStyleString:FontType = .Default
    var isFirstDiaryOfDay:Bool = true
    var settingView:Bool = false
    
    var body: some View {
        switch layoutIndex {
        case 1:
            cardView4
        case 2:
            cardView5
        case 3:
            cardView6
        case 4:
            cardView2
            //        case 5:
            //            cardView1
            //        case 6:
            //            cardView3
        default:
            cardView4
        }
    }
    
    //MARK: - LayOut1
    var cardView1 : some View {
        HStack(spacing:10){
            caleView1
                .opacity(isFirstDiaryOfDay ? 1 : 0.01)
            textView1
        }
    }
    var caleView1 : some View {
        VStack(spacing: 0){
            Text(e_create_date.getDayInWeek() )
                .foregroundColor(Color.white)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top,6)
                .padding(.bottom,3)
            Text(
                dateFormatterMMdd.string(from: e_create_date )
            )
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(appTheme.fontColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical,6)
            .background (appTheme.backColor3)
            .overlay(
                RoundedRectangle(cornerRadius: 11)
                    .stroke(Color.black,lineWidth: 3)
            )
            .cornerRadius(10)
        }
        .background(
            appTheme.backColor2
        )
        .frame(width: 48)
        .cornerRadius(12)
    }
    //    let title_key: LocalizedStringKey = "I am title!"
    //    let title_e = "I am title!"
    //    let body_e = "This is a preview window, tap to change the list layout .This is a preview window, tap to change the list layout ."
    var textView1 : some View {
        HStack(spacing:4){
            VStack(alignment:.leading, spacing:8){
                if settingView {
                    Text("I am title!")
                        .font(fontStyleString.titleFont)
                        .lineLimit(1)
                    Text("This is a preview window, tap to change the list layout .This is a preview window, tap to change the list layout .")
                        .font(fontStyleString.bodyFont)
                        .lineLimit(1)
                        .padding(.bottom,3)
                }else{
                    Text(e_title )
                        .font(fontStyleString.titleFont)//.font(.subheadline).fontWeight(.semibold)
                        .lineLimit(1)
                    Text(e_body )
                        .font(fontStyleString.bodyFont) //.font(.footnote)
                        .lineLimit(1)
                        .padding(.bottom,3)
                }
            }.frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment:.trailing, spacing:8){
                Image(systemName: "heart")
                    .font(.headline)
                    .symbolVariant(.fill)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .foregroundColor(e_isFav ? appHeartColor.SwiftUiColor : .clear)
                Text(dateFormatterHHmm.string(from: e_modified_date ))
                    .font(.footnote)
                    .frame(maxWidth: .infinity,alignment: .trailing)
            }.frame(width: 48,alignment: .trailing)
        }
        .padding(10)
        .background(appTheme.backColor)
        .cornerRadius(10)
        .frame(maxWidth:.infinity , alignment: .leading)
        .shadow(color:.gray,radius: 3,x: 5,y:5)
        .overlay(
            RoundedRectangle(cornerRadius: 10,style: .continuous)
                .stroke(.black,lineWidth: 1.5)
        )
    }
    
    
    //MARK: - LayOut2
    var cardView2 : some View {
        HStack(spacing:10){
            caleView2
            textView2
        }
    }
    var caleView2 : some View {
        VStack(spacing: 0){
            Text(e_create_date.getDayInWeek() )
            //MARK: - 日历上半部字体
                .foregroundColor(Color.white)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top,6)
                .padding(.bottom,3)
            Text(
                dateFormatterMMdd.string(from: e_create_date )
            )
            .font(.footnote)
            .fontWeight(.semibold)
            //MARK: - 日历下半部字体
            .foregroundColor(appTheme.fontColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical,6)
            //MARK: - 日历下半部background
            .background {appTheme.backColor3}
            .overlay(
                RoundedRectangle(cornerRadius: 11)
                    .stroke(Color.black,lineWidth: 2)
            )
            .cornerRadius(10)
        }
        //MARK: - 日历上半部background
        .background(content: {
            appTheme.backColor2
        })
        .frame(width: 48)
        .cornerRadius(12)
    }
    var textView2 : some View {
        HStack(spacing:4){
            VStack(alignment:.leading, spacing:8){
                if settingView {
                    Text("I am title!")
                        .font(fontStyleString.titleFont)
                        .lineLimit(1)
                    Text("This is a preview window, tap to change the list layout .This is a preview window, tap to change the list layout .")
                        .font(fontStyleString.bodyFont)
                        .lineLimit(1)
                        .padding(.bottom,3)
                }else{
                    Text(e_title )
                        .font(fontStyleString.titleFont)//.font(.subheadline).fontWeight(.semibold)
                        .lineLimit(1)
                    Text(e_body )
                        .font(fontStyleString.bodyFont) //.font(.footnote)
                        .lineLimit(1)
                        .padding(.bottom,3)
                }
            }.frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment:.trailing, spacing:8){
                Image(systemName: "heart.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .foregroundColor(e_isFav ? appHeartColor.SwiftUiColor: .clear)
                Text(dateFormatterHHmm.string(from: e_modified_date ))
                    .font(.footnote)
                    .frame(maxWidth: .infinity,alignment: .trailing)
            }.frame(width: 48,alignment: .trailing)
        }
        .padding(10)
        //MARK: - 文字板background
        .background(appTheme.backColor)
        .cornerRadius(10)
        .frame(maxWidth:.infinity , alignment: .leading)
        //        .shadow(color:.gray,radius: 2,x: 4,y:5)
        .overlay(
            RoundedRectangle(cornerRadius: 10,style: .continuous)
                .stroke(.black,lineWidth: 1)
        )
    }
    
    
    
    //MARK: - LayOut3
    var cardView3 : some View {
        HStack(spacing:0){
            caleView3
            textView3
        }.frame(height: 70)
    }
    var caleView3 : some View {
        VStack(spacing: 0){
            
            Text(e_create_date.getDayInWeek() )
            //MARK: - 日历上半部字体
                .foregroundColor(Color.white)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top,8)
                .padding(.bottom,4)
            Text(
                dateFormatterMMdd.string(from: e_create_date )
            )
            .font(.footnote)
            .fontWeight(.semibold)
            //MARK: - 日历下半部字体
            .foregroundColor(appTheme.fontColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical,11)
            //MARK: - 日历下半部background
            .background {appTheme.backColor3}
            .border(.black)
            //            .overlay(
            //                RoundedRectangle(cornerRadius: 11)
            //                    .stroke(Color.black,lineWidth: 2)
            //            )
            //            .cornerRadius(10)
        }
        //MARK: - 日历上半部background
        .background(content: {
            appTheme.backColor2
        })
        .frame(width: 48)
        //        .cornerRadius(12)
    }
    var textView3 : some View {
        HStack(spacing:4){
            VStack(alignment:.leading, spacing:8){
                if settingView {
                    Text("I am title!")
                        .font(fontStyleString.titleFont)
                        .lineLimit(1)
                    Text("This is a preview window, tap to change the list layout .This is a preview window, tap to change the list layout .")
                        .font(fontStyleString.bodyFont)
                        .lineLimit(1)
                        .padding(.bottom,3)
                }else{
                    Text(e_title )
                        .font(fontStyleString.titleFont)//.font(.subheadline).fontWeight(.semibold)
                        .lineLimit(1)
                    Text(e_body )
                        .font(fontStyleString.bodyFont) //.font(.footnote)
                        .lineLimit(1)
                        .padding(.bottom,3)
                }
            }.frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment:.trailing, spacing:8){
                Image(systemName: "heart.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .foregroundColor(e_isFav ? appHeartColor.SwiftUiColor: .clear)
                Text(dateFormatterHHmm.string(from: e_modified_date ))
                    .font(.footnote)
                    .frame(maxWidth: .infinity,alignment: .trailing)
            }.frame(width: 48,alignment: .trailing)
        }
        .padding(10)
        //MARK: - 文字板background
        .background(appTheme.backColor)
        //        .cornerRadius(10)
        .frame(maxWidth:.infinity,maxHeight: 70 , alignment: .leading)
        .border(.black)
        //        .shadow(color:.gray,radius: 2,x: 4,y:5)
        //        .overlay(
        //            RoundedRectangle(cornerRadius: 10,style: .continuous)
        //                .stroke(.black,lineWidth: 1)
        //        )
    }
    
    
    
    
    
    //MARK: - LayOut4
    var cardView4 : some View {
        HStack(spacing:0){
            textView4
        }
    }
    
    var textView4 : some View {
        HStack(spacing:4){
            VStack(alignment:.leading, spacing:6){
                if settingView {
                    Text("I am title!")
                        .font(fontStyleString.titleFont)
                        .lineLimit(1)
                    Text("This is a preview window, tap to change the list layout .This is a preview window, tap to change the list layout .")
                        .font(fontStyleString.bodyFont)
                        .lineLimit(2)
                        .padding(.bottom,3)
                }else{
                    Text(e_title )
                        .font(fontStyleString.titleFont)//.font(.subheadline).fontWeight(.semibold)
                        .lineLimit(1)
                    Text(e_body )
                        .font(fontStyleString.bodyFont) //.font(.footnote)
                        .lineLimit(2)
                        .padding(.bottom,3)
                }
            }.frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment:.trailing, spacing:6){
                Image(systemName: "heart.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .foregroundColor(e_isFav ? appHeartColor.SwiftUiColor: .clear)
                Text(dateFormatterMMdd.string(from: e_create_date ))
                    .font(.subheadline)
                    .frame(maxWidth: .infinity,alignment: .center)
            }.frame(width: 44,alignment: .trailing)
        }
        .padding(10)
        //MARK: - 文字板background
        .background(appTheme.backColor)
        .cornerRadius(10)
        .frame(maxWidth:.infinity , alignment: .leading)
        //        .shadow(color:.gray,radius: 2,x: 4,y:5)
        .overlay(
            RoundedRectangle(cornerRadius: 10,style: .continuous)
                .stroke(.black,lineWidth: 1)
        )
    }
    
    
    //MARK: - LayOut5
    var cardView5 : some View {
        HStack(spacing:0){
            textView5
        }
    }
    
    var textView5 : some View {
        HStack(spacing:4){
            VStack(alignment:.leading, spacing:6){
                if settingView {
                    Text("I am title!")
                        .font(fontStyleString.titleFont)
                        .lineLimit(1)
                    Text("This is a preview window, tap to change the list layout .This is a preview window, tap to change the list layout .")
                        .font(fontStyleString.bodyFont)
                        .lineLimit(2)
                        .padding(.bottom,3)
                }else{
                    Text(e_title )
                        .font(fontStyleString.titleFont)//.font(.subheadline).fontWeight(.semibold)
                        .lineLimit(1)
                    Text(e_body )
                        .font(fontStyleString.bodyFont) //.font(.footnote)
                        .lineLimit(2)
                        .padding(.bottom,3)
                }
            }.frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment:.trailing, spacing:6){
                Image(systemName: "heart.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .foregroundColor(e_isFav ? appHeartColor.SwiftUiColor: .clear)
                Text(dateFormatterMMdd.string(from: e_create_date ))
                    .font(.subheadline)
                    .frame(maxWidth: .infinity,alignment: .center)
            }.frame(width: 44,alignment: .trailing)
        }
        .padding(10)
        //MARK: - 文字板background
        .background(appTheme.backColor)
        .cornerRadius(10)
        .frame(maxWidth:.infinity , alignment: .leading)
        .border(.black)
        //        .shadow(color:.gray,radius: 2,x: 4,y:5)
        //        .overlay(
        //            RoundedRectangle(cornerRadius: 10,style: .continuous)
        //                .stroke(.black,lineWidth: 1)
        //        )
    }
    
    
    
    
    //MARK: - LayOut6
    var cardView6 : some View {
        HStack(spacing:0){
            textView6
        }
    }
    
    var textView6 : some View {
        HStack(spacing:4){
            VStack(alignment:.leading, spacing:5){
                if settingView {
                    HStack(spacing:0) {
                        Text("3-09 Thu / ")
                            .font(fontStyleString.titleFont)
                            .frame(alignment: .leading)
                            .lineLimit(1)
                        Text("I am title!")
                            .font(fontStyleString.titleFont)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .lineLimit(1)
                        Image(systemName: "heart.fill")
                            .font(.headline)
                            .frame(width: 50,alignment: .center)
                            .foregroundColor(e_isFav ? appHeartColor.SwiftUiColor: .clear)
                    }
                    Text("This is a preview window, tap to change the list layout .This is a preview window, tap to change the list layout .")
                        .font(fontStyleString.bodyFont)
                        .lineLimit(4)
                        .padding(.bottom,3)
                }else{
                    HStack {
                        Text("\(dateFormatterMMdd.string(from: e_create_date)) \(e_create_date.getDayInWeek()) / \(e_title)")
                            .font(fontStyleString.titleFont)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .lineLimit(1)
                        Image(systemName: "heart.fill")
                            .font(.headline)
                            .frame(width: 50,alignment: .center)
                            .foregroundColor(e_isFav ? appHeartColor.SwiftUiColor: .clear)
                    }
                    Text(e_body )
                        .font(fontStyleString.bodyFont)
                        .lineLimit(4)
                        .padding(.bottom,3)
                }
            }
            //            .background(appTheme.sysBack)
            .frame(maxWidth: .infinity,alignment: .leading)
            
            
        }
        .padding(.horizontal,10)
        
        //MARK: - 文字板background
        .background(appTheme.sysBack)
        .frame(maxWidth:.infinity , alignment: .leading)
    }
    
    
    
    
    
}


struct DiaryCardLayOutView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            DiaryCardLayOutView(e_isFav: true,layoutIndex: 6)
                .previewLayout(.sizeThatFits)
            DiaryCardLayOutView(e_isFav: true,layoutIndex: 6)
                .previewLayout(.sizeThatFits)
            //                .preferredColorScheme(.dark)
        }
    }
}
