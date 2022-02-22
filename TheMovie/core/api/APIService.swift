//
//  API.swift
//  TheMovie
//
//  Created by Monika Mateska on 20.2.22.
//

import Foundation
import UIKit

class APIService {
    static let shared = APIService()
    
    static let basePath = "https://api.themoviedb.org/3"
    static let posterBasePath = "https://image.tmdb.org/t/p/w500"
    private let popularMoviesPath = "movie/top_rated"
    
    /// Asynchronous fetches the popular movies.
    ///
    /// - Parameters:
    ///   - page, the current page.
    /// - Returns, list of PopularMovieModel or throws an error.
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
    
    /// Asynchronous fetches image.
    ///
    /// - Parameters:
    ///   - url, the image URL.
    /// - Returns, UIImage or throws an error.
    func fetchImage(url: URL) async throws -> UIImage {
        let (imageData, response) = try await URLSession.shared.data(from: url)
            
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.serverEror
        }
        
        guard let image = UIImage(data: imageData) else {
            throw APIError.decodingError
        }
        
        return image
    }
    
    // MARK: - private
    
    private func generatePopularMoviesUrl(page: Int) throws -> URL {
        var components = URLComponents(string: "\(APIService.basePath)/\(popularMoviesPath)")!
        
        let apiKey = try readAPIKey()
        
        components.queryItems = [
        URLQueryItem(name: "api_key", value: apiKey),
        URLQueryItem(name: "page", value: "\(page)")
        ]

        guard let url = components.url else {
            throw APIError.invalidUrl
        }

        return url
    }
    
    private func readAPIKey() throws -> String {
        guard let filePath = Bundle.main.path(forResource: "APIService-Info", ofType: "plist") else {
            throw APIError.cannotReadAPIKey
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            throw APIError.cannotReadAPIKey
        }
        
        return value
    }
}
