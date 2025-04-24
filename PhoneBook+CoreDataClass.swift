//
//  PhoneBook+CoreDataClass.swift
//  PokemonPhoneBook
//
//  Created by NH on 4/22/25.
//
//

import Foundation
import CoreData

@objc(PhoneBook)
public class PhoneBook: NSManagedObject {
    public static let className = "PhoneBook"
    public enum Key {
        static let imageUrl = "imageUrl"
        static let name = "name"
        static let phoneNumber = "phoneNumber"
    }
}
