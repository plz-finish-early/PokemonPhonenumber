//
//  EvolutionResult.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/22/25.
//

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
/*
func makeEvolutionArray(from chain: Chain) -> [String] {
    var result = [chain.species.name]
    
    for chain in chain.evolvesTo {
        result.append(contentsOf: makeEvolutionArray(from: chain))
    }
    
    return result
}
*/
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

//struct SpeciesObject: Decodable {
//    let name: String // 이름이 목적
//    let url: String
//}

