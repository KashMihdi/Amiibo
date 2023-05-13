//
//  NetworkManager.swift
//  HW 3.02
//
//  Created by Kasharin Mikhail on 09.05.2023.
//

import Foundation
import Alamofire

enum Link {
    case amiiboURL
    
    var url: URL {
        switch self {
        case .amiiboURL:
            return URL(string: "https://www.amiiboapi.com/api/amiibo/")!
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchAmiibo(from url: URL, completion: @escaping(Result<Amiibo, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let amiibo = Amiibo.getAmiibo(from: value)
                    completion(.success(amiibo))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
