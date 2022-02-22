//
//  PopularMoviesAPIResponse.swift
//  TheMovie
//
//  Created by Monika Mateska on 21.2.22.
//

import Foundation

struct PopularMoviesAPIResponse: Codable {
    let movies: [PopularMovieModel]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
