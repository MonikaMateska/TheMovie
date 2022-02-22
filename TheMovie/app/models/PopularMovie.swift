//
//  PopularMovies.swift
//  TheMovie
//
//  Created by Monika Mateska on 20.2.22.
//

import Foundation

/// A model representing a popular movie.
struct PopularMovieModel: Identifiable, Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String?
    let releaseDate: String
    
    var posterUrl: URL? {
        guard let posterPath = posterPath else { return nil }
        let components = URLComponents(string: "\(APIService.posterBasePath)\(posterPath)")!
        return components.url
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
}
