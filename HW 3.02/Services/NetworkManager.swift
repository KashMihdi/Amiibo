//
//  NetworkManager.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 09.05.2023.
//

import Foundation

enum Link {
    case amiiboURL
    
    var url: URL {
        switch self {
        case .amiiboURL:
            return URL(string: "https://www.amiiboapi.com/api/amiibo/")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}



final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
