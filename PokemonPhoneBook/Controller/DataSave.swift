//
//  DataSave.swift
//  PokemonPhoneBook
//
//  Created by NH on 4/22/25.
//

import Foundation
import CoreData

class DataSave {
    
    var container: NSPersistentContainer!
    
    func createData(name: String, phoneNumber: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: self.container.viewContext) else { return }
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: "name")
        newPhoneBook.setValue(phoneNumber, forKey: "phoneNumber")
        
        do {
            try self.container.viewContext.save()
            print("문맥 저장 성공")
        } catch {
            print("문맥 저장 실패")
        }
    }

    func readAllData() {
        do {
            let phoneBooks = try self.container.viewContext.fetch(PhoneBook.fetchRequest())
            
            for phoneBook in phoneBooks as [NSManagedObject] {
                if let name = phoneBook.value(forKey: "name") as? String,
                   let phoneNumber = phoneBook.value(forKey: "phoneNumber") {
                    print("name: \(name), phoneNumber: \(phoneNumber)")
                }
            }
        } catch {
            print("데이터 읽기 실패")
        }
    }
}
