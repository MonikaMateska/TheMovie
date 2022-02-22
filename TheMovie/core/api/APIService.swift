//
//  API.swift
//  TheMovie
//
//  Created by Monika Mateska on 20.2.22.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    let basePath = "https://api.themoviedb.org/3"
    private let popularMoviesPath = "movie/top_rated"
    
    private let apiKey = "" //TODO: read hashed api key
    
    func fetchPopularMovies(page: Int) async throws -> [PopularMovieModel] {
        let url = try generatePopularMoviesUrl(page: page)
        
        let (data, response) = try await URLSession.shared.data(from: url)
            
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.serverEror
        }

        guard let popularMoviesReponse = try? JSONDecoder()
          .decode(PopularMoviesAPIResponse.self, from: data) else {
              throw APIError.decodingError
        }
        
        return popularMoviesReponse.movies
    }
    
    func generatePopularMoviesUrl(page: Int) throws -> URL {
        var components = URLComponents(string: "\(basePath)/\(popularMoviesPath)")!
        components.queryItems = [
        URLQueryItem(name: "api_key", value: apiKey),
        URLQueryItem(name: "page", value: "\(page)")
        ]

        guard let url = components.url else {
            throw APIError.invalidUrl
        }

        return url
    }
}
