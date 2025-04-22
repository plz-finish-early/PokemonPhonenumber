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
    let officialArtwork: OfficialArtworkObject
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtworkObject: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
