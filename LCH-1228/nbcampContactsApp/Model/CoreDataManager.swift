//
//  CoreDataManager.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/17/25.
//
import UIKit
import CoreData

class CoreDataManager {
    static let shard: CoreDataManager = CoreDataManager()
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var container = appDelegate?.persistentContainer
    
    func createData(name: String, phoneNumber: String, profileImage: Data) {
        guard let container = self.container else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: PhoneBook.entityName, in: container.viewContext) else {
            print("entity 생성 실패")
            return
        }
        
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: container.viewContext)
        
        newPhoneBook.setValue(UUID(), forKey: PhoneBook.Key.uuid)
        newPhoneBook.setValue(name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(phoneNumber, forKey: PhoneBook.Key.phoneNumber)
        newPhoneBook.setValue(profileImage, forKey: PhoneBook.Key.profileImage)
        do {
            try container.viewContext.save()
            print("저장 성공")
        } catch {
            print("저장 실패")
        }
    }
    
    func readAllData() {
        guard let container = self.container else { return }
        do {
            let phoneBooks = try container.viewContext.fetch(PhoneBook.fetchRequest())
            
            for phoneBook in phoneBooks as [NSManagedObject] {
                guard let uuid = phoneBook.value(forKey: PhoneBook.Key.uuid) as? UUID else {
                    print("uuid 값 추출 실패")
                    return
                }
                guard let name = phoneBook.value(forKey: PhoneBook.Key.name) as? String else {
                    print("이름 값 추출 실패")
                    return
                }
                guard let phoneNumber = phoneBook.value(forKey: PhoneBook.Key.phoneNumber) as? String else {
                    print("번호 값 추출 실패")
                    return
                }
                guard let profileImage = phoneBook.value(forKey: PhoneBook.Key.profileImage) as? Data else {
                    print("이미지 값 추출 실패")
                    return
                }
                    print("uuid: \(uuid), name: \(name), phoneNumber: \(phoneNumber), profileImage: \(profileImage)")
                }
            print("전체 데이터 읽기 성공")
        } catch {
            print("데이터 읽기 실패")
        }
    }
    
    func getAllData() -> [(uuid: UUID, name: String, phoneNumber: String, profileImage: Data)] {
        guard let container = self.container else { return [] }
        var data: [(UUID, String, String, Data)] = []
        do {
            let phoneBooks = try container.viewContext.fetch(PhoneBook.fetchRequest())
            for phoneBook in phoneBooks as [NSManagedObject] {
                guard let uuid = phoneBook.value(forKey: PhoneBook.Key.uuid) as? UUID else {
                    print("uuid 추출 실패")
                    return []
                }
                guard let name = phoneBook.value(forKey: PhoneBook.Key.name) as? String else {
                    print("이름 추출 실패")
                    return []
                }
                guard let phoneNumber = phoneBook.value(forKey: PhoneBook.Key.phoneNumber) as? String else {
                    print("번호 추출 실패")
                    return []
                }
                guard let profileImage = phoneBook.value(forKey: PhoneBook.Key.profileImage) as? Data else {
                    print("이미지 추출 실패")
                    return []
                }
                data.append((uuid, name, phoneNumber, profileImage))
            }
            print("데이터 추출 성공")
            return data
        } catch {
            print("fetchRequest 실패")
            return []
        }
    }
    
    func updateData(uuid: UUID, updateName: String, updatephoneNumber: String, updateProfileImage: Data) {
        guard let container = self.container else { return }
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", uuid.uuidString)
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                data.setValue(UUID(), forKey: PhoneBook.Key.uuid)
                data.setValue(updateName, forKey: PhoneBook.Key.name)
                data.setValue(updatephoneNumber, forKey: PhoneBook.Key.phoneNumber)
                data.setValue(updateProfileImage, forKey: PhoneBook.Key.profileImage)
            }
            
            try container.viewContext.save()
            print("데이터 수정 성공")
        } catch {
            print("데이터 수정 실패")
        }
    }
    
    func deleteData(uuid: UUID) {
        guard let container = self.container else { return }
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", uuid.uuidString)
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                container.viewContext.delete(data)
            }
            
            try container.viewContext.save()
            
            print("데이터 삭제 성공")
        } catch {
            print("데이터 삭제 실패")
        }
    }
}
