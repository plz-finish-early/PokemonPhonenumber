//
//  PhoneBook+CoreDataClass.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/17/25.
//
//

import Foundation
import CoreData

@objc(PhoneBook)
public class PhoneBook: NSManagedObject {
    static let entityName = "PhoneBook"
    enum Key {
        static let name = "name"
        static let phoneNumber = "phoneNumber"
        static let profileImage = "profileImage"
        static let uuid = "uuid"
        static let imageName = "imageName"
    }
}
