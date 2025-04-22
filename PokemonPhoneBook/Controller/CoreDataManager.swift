//
//  CoreDataManager.swift
//  PokemonPhoneBook
//
//  Created by NH on 4/22/25.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    // 싱글톤
    static let shared = CoreDataManager(container: (UIApplication.shared.delegate as! AppDelegate).persistentContainer)
    
    var container: NSPersistentContainer!
    var phoneBooks: [NSManagedObject] = []
    
    // 초기화
    init(container: NSPersistentContainer!) {
        self.container = container
    }
    
    // 데이터 저장
    func createData(image: UIImage?, name: String, phoneNumber: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: self.container.viewContext) else { return }
        
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        
        newPhoneBook.setValue(name, forKey: "name")
        newPhoneBook.setValue(phoneNumber, forKey: "phoneNumber")
        
        // UIImage를 CoreData에 저장하려면 Data 타입으로 변환해야 됨.
        if let imageData = image?.pngData() {
            newPhoneBook.setValue(imageData, forKey: "image")
        }
        
        do {
            try self.container.viewContext.save()
            print("문맥 저장 성공")
        } catch {
            print("문맥 저장 실패")
        }
    }
    
    // 데이터 읽기
    func readAllData() {
        do {
            phoneBooks = try self.container.viewContext.fetch(PhoneBook.fetchRequest())
            
            for phoneBook in phoneBooks as [NSManagedObject] {
                let name = phoneBook.value(forKey: "name") as? String ?? "이름 없음"
                let phoneNumber = phoneBook.value(forKey: "phoneNumber") as? String ?? "번호 없음"
                if let image = phoneBook.value(forKey: "image") as? Data {
                    print("image: \(image), name: \(name), phoneNumber: \(phoneNumber)")
                } else {
                    print("image: 이미지 없음, name: \(name), phoneNumber: \(phoneNumber)")
                }
            }
        } catch {
            print("데이터 읽기 실패")
        }
    }
}
