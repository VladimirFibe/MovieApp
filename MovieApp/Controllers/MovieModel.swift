//
//  MovieModel.swift
//  MovieApp
//
//  Created by Artur Imanbaev on 05.04.2023.
//

import Foundation

struct Welcome: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
//extension Welcome {
//      init(from decoder: Decoder) throws {
//          let values = try decoder.container(keyedBy: CodingKeys.self)
//          page = try values.decode(Int.self, forKey: .page)
//          results = try values.decode([Result].self, forKey: .results)
//          totalPages = try values.decode(Int.self, forKey: .totalPages)
//          totalResults = try values.decode(Int.self, forKey: .totalResults)
//      }
//}

// MARK: - Result
struct Result: Codable {
    let adult: Bool
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
    let posterPath: String
    let release_date: String = ""

    enum CodingKeys: String, CodingKey {
        case adult
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case release_date
    }
}
//extension Result {
//      init(from decoder: Decoder) throws {
//          let values = try decoder.container(keyedBy: CodingKeys.self)
//          adult = try values.decode(Bool.self, forKey: .adult)
//          genreIDS = try values.decode([Int].self, forKey: .genreIDS)
//          id = try values.decode(Int.self, forKey: .id)
//          originalTitle = try values.decode(String.self, forKey: .originalTitle)
//          posterPath = try values.decode(String.self, forKey: .posterPath)
//          releaseDate = try values.decode(String.self, forKey: .releaseDate)
//      }
//}


