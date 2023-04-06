//
//  APICaller.swift
//  MovieApp
//
//  Created by Artur Imanbaev on 06.04.2023.
//

import Foundation

class APICaller{
    static let shared = APICaller()
    private init(){}
    func fetchRequest<T: Decodable>
    (urlString: String,
    expecting: T.Type,
     completion: @escaping (T)-> Void
    ){
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { data, response, err in
            if let err = err{
                print(err)
            }
            guard let data = data else {return}
            do {
                let obj = try JSONDecoder().decode(expecting.self, from: data)
                completion(obj)
            } catch let jsonErr{
                print("Failed \(jsonErr)")
            }
        }.resume()
    }
}
