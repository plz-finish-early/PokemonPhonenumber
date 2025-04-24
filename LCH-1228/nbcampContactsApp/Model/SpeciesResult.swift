//
//  SpeciesResult.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/22/25.
//

//진화 기능 구현시 포켓몬 정보 디코딩을 위한 구조체
struct SpeciesResult: Decodable {
    let evolutionChain: EvolutionObject
    
    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
    }
}

struct EvolutionObject: Decodable {
    let url: String
}
