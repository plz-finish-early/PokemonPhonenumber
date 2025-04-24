//
//  Contact.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/22/25.
//

import Foundation

//CoreData 입출력 데이터 모델
struct Contact {
    let uuid: UUID
    let name: String
    let phoneNumber: String
    let profileImage: Data
    let imageName: String
}
