//
//  PokemonModel.swift
//  PokemonPhonebook
//
//  Created by 전원식 on 4/23/25.
//

import Foundation

struct Pokemon: Codable {
    let sprites: Sprites
}

struct Sprites: Codable {
    let front_default: String?
}
