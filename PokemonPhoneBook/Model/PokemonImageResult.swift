//
//  PokemonImageResult.swift
//  PokemonPhoneBook
//
//  Created by NH on 4/18/25.
//
import Foundation
struct PokemonImageResult: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: PokemonSprites
}

struct PokemonSprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
