//
//  PhoneBook+CoreDataClass.swift
//  pokemony
//
//  Created by JIN LEE on 4/15/25.
//
//

import Foundation
import CoreData

@objc(PhoneBook)
public class PhoneBook: NSManagedObject {
    public static let className: String = "PhoneBook"
    public enum Key {
        static let name = "name"
        static let phoneNumber = "phoneNumber"
    }

}
