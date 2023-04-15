import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable, Hashable {
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
