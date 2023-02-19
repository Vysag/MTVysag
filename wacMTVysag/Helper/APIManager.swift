//
//  APIManager.swift
//  wacMTVysag
//
//  Created by vysag k on 18/02/23.
//

import Foundation
import SwiftUI
enum DataError:Error{
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

typealias Handler = (Result<Home, DataError>) -> Void
final class APIManager{
    static let shared = APIManager()
    private init() {}
        
    func fetchProducts(completion:@escaping Handler){
        guard let url = URL(string: Constant.API.homeURL) else{
            
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data , error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response  as? HTTPURLResponse,
            200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let products = try JSONDecoder().decode(Home.self, from: data)
                completion(.success(products))
            }catch{
                completion(.failure(.network(error)))
            }
        }.resume()
    }
}
