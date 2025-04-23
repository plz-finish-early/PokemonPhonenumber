//
//  Untitled.swift
//  pokemony
//
//  Created by JIN LEE on 4/22/25.
//

import Foundation

struct PokemonData: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    
    struct Sprites: Decodable {
        let frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
