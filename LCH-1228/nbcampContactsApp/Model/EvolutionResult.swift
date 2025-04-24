//
//  EvolutionResult.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/22/25.
//

//진화 기능 구현시 디코딩을 위한 구조체
struct EvolutionResult: Decodable {
    let chain: Chain
}

struct Chain: Decodable {
    let evolvesTo: [Chain]
    let species: SpeciesObject
    
    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case species
    }
}

//재귀형 JSON 디코딩을 위한 메서드
func makeEvolutionArray(from chain: Chain) -> [[String]] {
    var result = [[chain.species.name]]
    
    var data = chain.evolvesTo

    while !data.isEmpty {
        var chain: [Chain] = []
        var speciesNames: [String] = []
        
        for evolution in data {
            speciesNames.append(evolution.species.name)
            chain.append(contentsOf: evolution.evolvesTo)
        }
        
        if !speciesNames.isEmpty {
            result.append(speciesNames)
        }
        
        data = chain
    }
    
    return result
}
