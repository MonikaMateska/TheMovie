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
    let posterUrl: String?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterUrl = "poster_path"
        case overview = "overview"
    }
}
