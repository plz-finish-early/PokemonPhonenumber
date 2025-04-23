//
//  NetworkServices.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/22/25.
//
import Foundation
import Alamofire

class NetworkServices {
    
    func fetchRandomData(completion: @escaping (Result<RandomResult, AFError>) -> Void) {
        let ramdomNumber = Int.random(in: 1...1025)
        var urlComponent = URLComponents(string: "https://pokeapi.co")
        
        urlComponent?.path = "/api/v2/pokemon/\(ramdomNumber)"
        
        guard let url = urlComponent?.url else {
            print("url 생성 실패")
            return
        }
        
        AF.request(url).responseDecodable(of: RandomResult.self) { response in
            completion(response.result)
        }
    }
    
    func fetchDataByName(name: String, completion: @escaping (Result<RandomResult, AFError>) -> Void) {
        var urlComponent = URLComponents(string: "https://pokeapi.co")
        
        urlComponent?.path = "/api/v2/pokemon/\(name)"
        
        guard let url = urlComponent?.url else {
            print("url 생성 실패")
            return
        }
        AF.request(url).responseDecodable(of: RandomResult.self) { response in
            completion(response.result)
        }
    }
    
    func fetchEvolutionData(name: String, completion: @escaping (Result<EvolutionResult, AFError>) -> Void) {
        var urlComponent = URLComponents(string: "https://pokeapi.co")
        
        urlComponent?.path = "/api/v2/pokemon/\(name)"
        
        guard let url = urlComponent?.url else {
            print("url 생성 실패")
            return
        }
        
        AF.request(url).responseDecodable(of: RandomResult.self) { response in
            guard let value = response.value?.species.url else { return }
            guard let url = URL(string: value) else { return }
            AF.request(url).responseDecodable(of: SpeciesResult.self) { response in
                guard let value = response.value?.evolutionChain.url else { return }
                guard let url = URL(string: value) else { return }
                AF.request(url).responseDecodable(of: EvolutionResult.self) { response in
                    completion(response.result)
                }
            }
        }
    }
}

