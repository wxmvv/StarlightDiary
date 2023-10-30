//
//  DiaryViewModel.swift
//  mmDiary
//
//  Created by wxm on 2022/9/22.
//
//https://cloud.tencent.com/developer/ask/sof/926782

import Foundation
import CoreData
import SwiftUI



//MARK: - manager
class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container:NSPersistentContainer
    let context:NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "StarlightDiary")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error loading coredata\(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("save successfully!")
        } catch let error {
            print("error saving coredata\(error)")
        }
    }
    
}





//MARK: - diaryViewModel
class DiaryViewMode:ObservableObject{
    
    let manager = CoreDataManager.instance
    
    @Published var coredata_diarys: [DiaryEntity] = []
    @Published var groupedEntities :  [String:[DiaryEntity]] = [:]
    
    //MARK: - 初始化
    init() {
        fetchDiary()
        getCreatDate()
        //MARK: - test
        for i in coredata_creatDate {
            print(i.dayStr as Any)
            for a in i.diary! {
                print(a)
            }
        }
        
    }
    
    
    
    //MARK: - Diary
    func fetchDiary() {
        let request = NSFetchRequest<DiaryEntity>(entityName: "DiaryEntity")
        do {coredata_diarys = try manager.context.fetch(request)
        } catch let error {print("error fetch.\(error)")}
        if coredata_diarys != [] {
            groupedEntities = Dictionary(grouping: coredata_diarys, by: { dateFormatteryyyyMMdd.string(from: $0.create_date!) })}
    }
    
    func saveDiary(){
        manager.save()
        fetchDiary()
    }
    
    
    func addDiary(titlestr:String,bodystr:String){
        let newDiary = DiaryEntity(context: manager.context)
        //        newDiary.id = UUID()
        newDiary.title = titlestr
        newDiary.body = bodystr
        newDiary.create_date = Date()
        newDiary.modified_date = newDiary.create_date
        newDiary.is_fav = false
        newDiary.createdate_relation = searchAndNewCreateDate(diaryEntity: newDiary)
        saveDiary()
    }
    
    func updateDiary(titlestr:String,bodystr:String,entity:DiaryEntity?) {
        let newTitle = titlestr
        let newBody = bodystr
        entity?.title = newTitle
        entity?.body = newBody
        entity?.modified_date = Date()
        saveDiary()
    }
    
    func favToggle(entity:DiaryEntity){
        let currentIsfav = entity.is_fav
        entity.is_fav = !currentIsfav
        saveDiary()
        
    }
    
    func deleteDiaryWithIndexSet(indexSet:IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = coredata_diarys[index]
        manager.context.delete(entity)
        searchAndDeleteCreateDate(diaryEntity: entity)
        saveDiary()
    }
    
    func deleteDiaryWithEntity(entity:DiaryEntity) {
        let en = entity
        manager.context.delete(en)
        saveDiary()
    }
    
    //MARK: - 导出功能
    @State private var isShareSheetShowing = false
    
    func exportAllToCSV() {
        //csv抬头
        let fileName = "mwDiary - \(exportDateFormatteryyyyMMddHHmmss.string(from:Date())).csv"
        //设定地址 不用管
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        //csv表头
        var csvText = "create_date,modified_date,title,body,is_fav\n"
        //csv表内容
        for dia in self.coredata_diarys {
            csvText += "\(exportDateFormatteryyyyMMddHHmmss.string(from: dia.create_date!)),\(exportDateFormatteryyyyMMddHHmmss.string(from: dia.create_date!)),\(dia.title ?? "no title"),\(dia.body ?? "no body"),\(dia.is_fav)\n"
        }
        //写入文件
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        print(path ?? "not found")
        //弹出分享栏
        var filesToShare = [Any]()
        filesToShare.append(path!)
            
        let av = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
        //MARK: ipad分享问题
        //参考 https://blog.csdn.net/madaxin/article/details/118482938
        if UIDevice.current.model.lowercased()=="ipad"{
            let sourceView = UIApplication.shared.windows[0].rootViewController!.view
            var frame = sourceView!.frame
            frame.size.height /= 2
            frame.origin.x = 0
            frame.origin.y = 0
            av.popoverPresentationController?.sourceView = sourceView
            av.popoverPresentationController?.sourceRect = frame
            av.popoverPresentationController?.permittedArrowDirections = .up
            UIApplication.shared.connectedScenes
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?.windows.first!.rootViewController?.present(av, animated: true, completion: nil)
        }else{
            UIApplication.shared.connectedScenes
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?.windows.first!.rootViewController?.present(av, animated: true, completion: nil)
        }
        isShareSheetShowing.toggle()
        
    }
    
    
    //MARK: - CreateDate
    @Published var coredata_creatDate : [CreateDate] = []
    
    //fetch
    func getCreatDate(){
        let req = NSFetchRequest<CreateDate>(entityName: "CreateDate")
        do {
            coredata_creatDate = try manager.context.fetch(req)
        } catch let error {
            print("error fetching \(error)")
        }
    }
    
    func deleteCreatDateWithCreateDate(creatDate:CreateDate){
        manager.context.delete(creatDate)
        saveCreateDate()
    }
    
    func saveCreateDate() {
        manager.save()
        getCreatDate()
    }
    
    
    //adddiary之后执行
    func searchAndNewCreateDate(diaryEntity:DiaryEntity) -> CreateDate?{
        
        let a = coredata_creatDate.filter(
            {$0.dayStr == dateFormatteryyyyMMdd.string(from:diaryEntity.create_date!)})
        if  a != [] {
            print("已存在\(diaryEntity.create_date ?? Date())")
            return a[0]
        } else {
            let new = CreateDate(context: manager.context)
            new.day = diaryEntity.create_date
            new.dayStr = dateFormatteryyyyMMdd.string(from:diaryEntity.create_date ?? Date())
            saveCreateDate()
            return new
        }
        
    }
    
    func searchAndDeleteCreateDate(diaryEntity:DiaryEntity){
        let deletedaystr = dateFormatteryyyyMMdd.string(from:diaryEntity.create_date!)
        
        let a = coredata_creatDate.filter(
            {$0.dayStr == deletedaystr})
        if  a != [] {
            print("还有其他日记，不需要删除日期\(diaryEntity.create_date ?? Date())")
        } else if a == [] {
            deleteCreatDateWithCreateDate(creatDate: a[0])
            print("删除日期")
        }
        
    }
    
    
    
}



