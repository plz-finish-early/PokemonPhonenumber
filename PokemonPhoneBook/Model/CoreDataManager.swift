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
    func createData(imageUrl: String?, name: String, phoneNumber: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: PhoneBook.className, in: self.container.viewContext) else { return }
        
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        
        newPhoneBook.setValue(name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(phoneNumber, forKey: PhoneBook.Key.phoneNumber)
        
        // UIImage를 CoreData에 저장하려면 Data 타입으로 변환해야 됨.
        if let imageUrl = imageUrl {
            newPhoneBook.setValue(imageUrl, forKey: PhoneBook.Key.imageUrl)
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
        // 데이터 요청
        let request = NSFetchRequest<NSManagedObject>(entityName: PhoneBook.className)
        
        // 이름 순으로 정렬 (오름차순)
        let sortDescriptor = NSSortDescriptor(key: PhoneBook.Key.name, ascending: true)
        
        // 정렬 기준 적용
        request.sortDescriptors = [sortDescriptor]
        
        do {
            phoneBooks = try self.container.viewContext.fetch(request)
            
            for phoneBook in phoneBooks as [NSManagedObject] {
                let name = phoneBook.value(forKey: PhoneBook.Key.name) as? String ?? "이름 없음"
                let phoneNumber = phoneBook.value(forKey: PhoneBook.Key.phoneNumber) as? String ?? "번호 없음"
                if let image = phoneBook.value(forKey: PhoneBook.Key.imageUrl) as? String {
                    print("imageUrl: \(image), name: \(name), phoneNumber: \(phoneNumber)")
                } else {
                    print("imageUrl: 이미지 없음, name: \(name), phoneNumber: \(phoneNumber)")
                }
            }
        } catch {
            print("데이터 읽기 실패")
        }
    }
    
    // CoreData 에서 데이터 업데이트
    func updateData(currentImageUrl: String,
                    updateImageUrl: String,
                    currentName: String,
                    updateName: String,
                    currentPhoneNumber: String,
                    updatePhoneNumber: String) {
        let fetchRequest = PhoneBook.fetchRequest()
        
        // predicate 는 조건을 걸어주는 구문
        // 예외처리: imageUrl 이 "" 면 nil 인 값을 찾게 함.
        fetchRequest.predicate = NSPredicate(format: "(imageUrl == %@ OR imageUrl == nil) AND name == %@ AND phoneNumber == %@", currentImageUrl, currentName, currentPhoneNumber)
        do {
            let result = try self.container.viewContext.fetch(fetchRequest)

            if let objectToUpdate = result.first {
                objectToUpdate.setValue(updateImageUrl, forKey: "imageUrl")
                objectToUpdate.setValue(updateName, forKey: "name")
                objectToUpdate.setValue(updatePhoneNumber, forKey: "phoneNumber")
                
                try self.container.viewContext.save()
                print("데이터 수정 성공")
            } else {
                print("일치하는 데이터 없음")
            }
        } catch {
            print("데이터 수정 실패")
        }
    }
}
