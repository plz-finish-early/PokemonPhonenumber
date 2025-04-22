//
//  NetworkServices.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/22/25.
//
import Foundation

class NetworkServices {
    
    func fetchData<T>(url: URL, completion: @escaping (T?) -> Void) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else {
                print("데이터 받아오기 실패")
                completion(nil)
                return
            }
            
            let successHttpResponeRange = 200..<300
            if let response = response as? HTTPURLResponse, successHttpResponeRange.contains(response.statusCode) {
                completion(data as? T)
            } else {
                print("응답 오류")
                completion(nil)
            }
        }.resume()
    }
}
