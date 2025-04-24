//
//  CoreDataManager.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/17/25.
//
import UIKit
import CoreData

//CoreData 입출력을 관리하는 CoreDataManager 정의
class CoreDataManager {
    
    //프로젝트 내에서 동일한 인스턴스 사용을 위해 싱글턴 패턴 사용
    static let shared: CoreDataManager = CoreDataManager()
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var container = appDelegate?.persistentContainer
    
    //데이터 생성 메서드
    func createData(contact: Contact) {
        guard let container = self.container else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: PhoneBook.entityName, in: container.viewContext) else {
            print("entity 생성 실패")
            return
        }
        
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: container.viewContext)
        
        newPhoneBook.setValue(UUID(), forKey: PhoneBook.Key.uuid) // UUID는 외부로부터 받지 않고 데이터 저장시 생성
        newPhoneBook.setValue(contact.name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(contact.phoneNumber, forKey: PhoneBook.Key.phoneNumber)
        newPhoneBook.setValue(contact.profileImage, forKey: PhoneBook.Key.profileImage)
        newPhoneBook.setValue(contact.imageName, forKey: PhoneBook.Key.imageName)
        do {
            try container.viewContext.save()
            print("저장 성공")
        } catch {
            print("저장 실패")
        }
    }
    
    //디버깅을 위해 CoreData를 print하는 메서드
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
                guard let imageName = phoneBook.value(forKey: PhoneBook.Key.imageName) as? String else {
                    print("이름 추출 실패")
                    return
                }
                    print("uuid: \(uuid), name: \(name), phoneNumber: \(phoneNumber), profileImage: \(profileImage), imageName: \(imageName)")
                }
            print("전체 데이터 읽기 성공")
        } catch {
            print("데이터 읽기 실패")
        }
    }
    
    //모든 데이터를 반환하는 메서드
    func getAllData() -> [Contact] {
        guard let container = self.container else { return [] }
        var allData: [Contact] = []
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
                guard let imageName = phoneBook.value(forKey: PhoneBook.Key.imageName) as? String else {
                    print("이름 추출 실패")
                    return []
                }
                let data = Contact(uuid: uuid, name: name, phoneNumber: phoneNumber, profileImage: profileImage, imageName: imageName)
                allData.append(data)
            }
            print("데이터 추출 성공")
            return allData
        } catch {
            print("fetchRequest 실패")
            return []
        }
    }
    
    //데이터 수정을 위한 메서드
    func updateData(contact: Contact) {
        guard let container = self.container else { return }
        let fetchRequest = PhoneBook.fetchRequest()
        
        //데이터 수정시 중복을 피하기위해 uuid를 기준으로 데이터 업데이트
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", contact.uuid.uuidString)
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                data.setValue(contact.uuid, forKey: PhoneBook.Key.uuid)
                data.setValue(contact.name, forKey: PhoneBook.Key.name)
                data.setValue(contact.phoneNumber, forKey: PhoneBook.Key.phoneNumber)
                data.setValue(contact.profileImage, forKey: PhoneBook.Key.profileImage)
                data.setValue(contact.imageName, forKey: PhoneBook.Key.imageName)
            }
            
            try container.viewContext.save()
            print("데이터 수정 성공")
        } catch {
            print("데이터 수정 실패")
        }
    }
    
    //데이터 삭제를 위한 메서드
    func deleteData(contact: Contact) {
        guard let container = self.container else { return }
        let fetchRequest = PhoneBook.fetchRequest()
        
        //데이터 삭제시 지정한 데이터만 삭제하기위해 uui를 기준으로 삭제
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", contact.uuid.uuidString)
        
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
