//
//  NetworkServices.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/22/25.
//
import Foundation
import Alamofire

class NetworkServices {
    
    //랜덤한 데이터를 가져오는 메서드
    func fetchRandomData(completion: @escaping (Result<RandomResult, Error>) -> Void) {
        let ramdomNumber = Int.random(in: 1...1025)
        var urlComponent = URLComponents(string: "https://pokeapi.co")
        
        urlComponent?.path = "/api/v2/pokemon/\(ramdomNumber)"
        
        guard let url = urlComponent?.url else {
            completion(.failure(CustomNetworkError.failedGeratingRandomURL))
            return
        }
        
        AF.request(url).responseDecodable(of: RandomResult.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //이름을 기준으로 데이터를 가져오는 메서드
    func fetchDataByName(name: String, completion: @escaping (Result<RandomResult, Error>) -> Void) {
        var urlComponent = URLComponents(string: "https://pokeapi.co")
        
        urlComponent?.path = "/api/v2/pokemon/\(name)"
        
        guard let url = urlComponent?.url else {
            completion(.failure(CustomNetworkError.invalidURL))
            return
        }
        
        AF.request(url).responseDecodable(of: RandomResult.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //진화 기능을 위해서 데이터를 가져오는 메서드
    func fetchEvolutionData(name: String, completion: @escaping (Result<EvolutionResult, Error>) -> Void) {
        var urlComponent = URLComponents(string: "https://pokeapi.co")
        
        urlComponent?.path = "/api/v2/pokemon/\(name)"
        
        guard let url = urlComponent?.url else {
            completion(.failure(CustomNetworkError.invalidURL))
            return
        }
        
        AF.request(url).responseDecodable(of: RandomResult.self) { response in
            guard let value = response.value?.species.url else { return }
            guard let url = URL(string: value) else { return }
            switch response.result {
            case .success(_):
                AF.request(url).responseDecodable(of: SpeciesResult.self) { response in
                    guard let value = response.value?.evolutionChain.url else { return }
                    guard let url = URL(string: value) else { return }
                    switch response.result {
                    case .success(_):
                        AF.request(url).responseDecodable(of: EvolutionResult.self) { response in
                            switch response.result {
                            case .success(let result):
                                completion(.success(result))
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
