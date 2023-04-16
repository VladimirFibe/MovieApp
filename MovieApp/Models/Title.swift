import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable, Hashable {
    let adult: Bool
    let genreIds: [Int]
    let id: Int
    let originalTitle: String
    let posterPath: String
}
