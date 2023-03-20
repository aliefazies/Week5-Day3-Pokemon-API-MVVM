//
//  ApiService.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 15/03/23.
//

import Foundation
import Alamofire

protocol ApiServiceProtocol {
    mutating func get(url: URL)
    func loadPokemon<T: Codable>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    func loadDetailPokemon<T: Codable>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

struct ApiService: ApiServiceProtocol {
    
    private var url = URL(string: "")
    
    mutating func get(url: URL) {
        self.url = url
    }
    
    func loadPokemon<T>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        guard let url = self.url else { return }
        
        AF.request(url, method: .get).responseData { dataResponse in
            if let data = dataResponse.data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Oops Something went wrong!"])
                completion(.failure(error))
            }
        }.resume()
    }
    
    func loadDetailPokemon<T>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        guard let url = self.url else { return }
        
        // MARK: - Tambahin Request AlamoFire
        AF.request(url, method: .get).responseData { dataDetailResponse in
            if let data = dataDetailResponse.data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Oops Something went wrong!"])
                completion(.failure(error))
            }
        }.resume()
    }
}
