//
//  FetchImage.swift
//  PokemonPhoneBook
//
//  Created by NH on 4/22/25.
//

import Foundation
import UIKit

class FetchAPI {
    
    static let shared = FetchAPI()
    
    func fetchPokemonImage(completion: @escaping (UIImage?, String?) -> Void) {
        let randomNumber = Int.random(in: 1...1000) // 랜덤한 숫자 생성
        // 랜덤 포켓몬 이미지 URL 생성
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomNumber)") else {
            print("잘못된 URL")
            completion(nil, nil)
            return
        }
        fetchData(url: url) { (result: PokemonImageResult?) in
            guard let result else {
                print("API 데이터 가져오기 실패")
                return
            }
            
            let imageUrlStr = result.sprites.frontDefault
            guard let imageUrl = URL(string: imageUrlStr) else {
                print("이미지 불러오기 실패")
                return
            }
            
            // 이미지 데이터 가져오기
            if let data = try? Data(contentsOf: imageUrl),
               let image = UIImage(data: data) {
                completion(image, imageUrlStr)
            } else {
                completion(nil, nil)
            }
        }
    }

    private func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else {
                print("데이터 로드 실패")
                completion(nil)
                return
            }
            let successRange = 200..<300
            
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                let decodedData = try? JSONDecoder().decode(T.self, from: data)
                completion(decodedData)
            } else {
                print("응답 오류")
                completion(nil)
            }
        }.resume()
    }
}
