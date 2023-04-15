//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Павел Грицков on 15.04.23.
//

import Foundation

class NetworkManager {
    
    private let APIKey = "c2583eab7c241bb1dbb645a93f7bbc22"
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/discover/movie?api_key=" + APIKey
    }
    
//    func fetchRequestPopularMovie(complition: @escaping ([MovieData]) -> Void) {
//        let urlString = baseURL + "&language=en-US&sort_by=popularity.asc&page=1"
//        
//        performRequest(with: urlString) { result in
//            switch result {
//            case .success(let success):
//                ///
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }

    func performRequest(with urlString: String, complition: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                complition(.failure(error))
                print("Ошибка: \(error)")
            }
            
            if let data {
                complition(.success(data))
                print(data)
            }
        }
        task.resume()
    }
    
    func parseData<T: Decodable>(decodble type: T, data: Data) -> T? {
        do {
            let resultDecoder = try JSONDecoder().decode(T.self, from: data)
            return resultDecoder
        } catch {
            print(error)
            return nil
        }
    }
}
