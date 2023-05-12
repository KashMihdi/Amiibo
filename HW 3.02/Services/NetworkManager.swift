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

enum NetworkError: Error {
    case noData
    case decodingError
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
//    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: url) else {
//                completion(.failure(.noData))
//                return
//            }
//            DispatchQueue.main.async {
//                completion(.success(imageData))
//            }
//        }
//    }
    
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
    
//    func fetchCourses(from url: URL, completion: @escaping(Result<[Course], AFError>) -> Void) {
//        AF.request(url)
//            .validate()
//            .responseJSON { dataResponse in
//                switch dataResponse.result {
//                case .success(let value):
//                    let courses = Course.getCourses(from: value)
//                    completion(.success(courses))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
}
