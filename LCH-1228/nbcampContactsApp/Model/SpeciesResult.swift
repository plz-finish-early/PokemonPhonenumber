//
//  SpeciesResult.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/22/25.
//

struct SpeciesResult: Decodable {
    let evolutionChain: EvolutionObject
    
    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
    }
}

struct EvolutionObject: Decodable {
    let url: String
}
