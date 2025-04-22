//
//  FetchImage.swift
//  PokemonPhoneBook
//
//  Created by NH on 4/22/25.
//

import Foundation
import UIKit

//class FetchImage {
//    // MARK: - API 데이터 가져오기
//    private func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Data?) {
//        let session = URLSession(configuration: .default)
//        
//        session.dataTask(with: URLRequest(url: url)) { data, response, error in
//            guard let data, error == nil else {
//                print("데이터 로드 실패")
//                completion(nil)
//                return
//            }
//            let successRange = 200..<300
//            
//            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
//                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
//                    print(response.statusCode, "JSON 디코딩 실패")
//                    completion(nil)
//                    return
//                }
//                completion(decodedData)
//            } else {
//                print("응답 오류")
//                completion(nil)
//            }
//        }.resume()
//    }
//    
//    private func fetchPokemonImage() {
//        let ramdomNumber = String(Int.random(in: 1...1000))
//        let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(ramdomNumber)")
//        
//        guard let url = urlComponents?.url else {
//            print("잘못된 URL")
//            return
//        }
//        
//        fetchData(url: url) { [weak self] (result: PokemonImageResult?) in
//            guard let self, let result else { return nil }
//
//            
//            guard let imageUrl = URL(string: "\(result.sprites.frontDefault)") else {
//                print("이미지 불러오기 실패")
//                return
//            }
//            
//            if let data = try? Data(contentsOf: imageUrl) {
////                if let image = UIImage(data: data) {
////                    DispatchQueue.main.async {
////                        profileImageView.image = image
////                    }
////                }
//                return data
//            }
//        }
//    }
//}
