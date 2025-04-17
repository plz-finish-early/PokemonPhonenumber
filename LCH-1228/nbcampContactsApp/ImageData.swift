//
//  ImageData.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/16/25.
//

struct ImageData: Codable {
    let sprites: SpritesObject
}

struct SpritesObject: Codable {
    let other : OtherObject
}

struct OtherObject: Codable {
    let home: HomeObject
}

struct HomeObject: Codable {
    
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
