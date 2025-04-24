//
//  PhoneBook+CoreDataProperties.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/17/25.
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
    @NSManaged public var uuid: UUID?
    @NSManaged public var imageNmae: String?

}

extension PhoneBook : Identifiable {

}
