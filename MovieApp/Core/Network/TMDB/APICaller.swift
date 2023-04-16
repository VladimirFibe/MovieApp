import Foundation

enum NetworkError: Error {
    case invalidQuery
    case invalidURL
    case invalidResponse
    case decodingError
    case failedTogetData
}

final class APICaller {
    static let shared = APICaller()
    let token = "d05573814638e3e0806fd4c425fe676a"
    let baseURL = "https://api.themoviedb.org"
    let youtubeAPI_KEY = "AIzaSyASko4P7m_RyMZjJwq3EC3o0a2z9STm39o"
    let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    private init() {}
    
    func request<Response: Decodable>(path: String) async throws -> Response {
        guard let url = URL(string: path) else { throw NetworkError.invalidURL}
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let result = try? decoder.decode(Response.self, from: data) else {
            throw NetworkError.decodingError
        }
        return result
    }
    
    func getMovie(with query: String) async throws -> VideoElement {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { throw NetworkError.invalidQuery}
        let result: YoutubeSearchResponse = try await request(path: "\(youtubeBaseURL)q=\(query)&key=\(youtubeAPI_KEY)")
        return result.items[0]
    }
    
    func getTrendingMovies() async throws -> TrendingTitleResponse {
        try await request(path: "\(baseURL)/3/trending/movie/day?api_key=\(token)")
    }
    
    func getTrendingTvs() async throws -> TrendingTitleResponse {
        try await request(path: "\(baseURL)/3/trending/tv/day?api_key=\(token)")
    }
    
    func getUpcomingMovies() async throws -> TrendingTitleResponse {
        try await request(path: "\(baseURL)/3/movie/upcoming?api_key=\(token)&language=en-US&page=1")
    }
    
    func getPopular() async throws -> TrendingTitleResponse {
        try await request(path: "\(baseURL)/3/movie/popular?api_key=\(token)&language=en-US&page=1")
    }
    
    func getTopRated() async throws -> TrendingTitleResponse {
        try await request(path: "\(baseURL)/3/movie/top_rated?api_key=\(token)&language=en-US&page=1")
    }
    
    func getDiscoverMovies() async throws -> TrendingTitleResponse {
        try await request(path: "\(baseURL)/3/discover/movie?api_key=\(token)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")
    }
    
    func search(with query: String) async throws -> TrendingTitleResponse {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { throw NetworkError.invalidQuery}
        return try await request(path: "\(baseURL)/3/search/movie?api_key=\(token)&query=\(query)")
    }
}
