//
//  NetworkServices.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/22/25.
//
import Foundation
import Alamofire

class NetworkServices {
    func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
}
