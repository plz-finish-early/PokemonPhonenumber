//
//  ImageData.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/16/25.
//

struct RandomResult: Decodable {
    let species: SpeciesObject
    let sprites: SpritesObject
}

struct SpeciesObject: Decodable {
    let name: String //대상 이름
    let url: String //종 정보
}

struct SpritesObject: Decodable {
    let other : OtherObject
}

struct OtherObject: Decodable {    let officialArtwork: OfficialArtworkObject
    
    private enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtworkObject: Decodable {
    let frontDefault: String //정면 이미지
    
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
