//
//  PhoneBook+CoreDataProperties.swift
//  pokemony
//
//  Created by JIN LEE on 4/15/25.
//
//

import Foundation
import CoreData


extension PhoneBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var profileImage: Data?

}

extension PhoneBook : Identifiable {

}
