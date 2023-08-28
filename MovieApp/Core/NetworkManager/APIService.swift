//
//  APIService.swift
//  MovieApp
//
//  Created by Dmitriy Babichev on 10.04.2023.
//

import Foundation

class APIService {
    
    static var shared = APIService()
    private let APIKey = "c2583eab7c241bb1dbb645a93f7bbc22"
    private let session = URLSession(configuration: .default)

    func getMovies(for query: String, completion: @escaping ([MovieData]?, Error?) -> Void) {
        guard let formatedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(APIKey)&query=\(formatedQuery)") else { return }

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
            }
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(ThemoviedbData.self, from: data)
                    completion(decodedData.results, nil)
                }
                catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
