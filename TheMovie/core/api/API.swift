//
//  API.swift
//  TheMovie
//
//  Created by Monika Mateska on 20.2.22.
//

import Foundation

class API {
    
    func fetchPopularMovies() async throws -> [PopularMovieModel] {
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)  // Two seconds
        let list = PopularMovieMocks.popularMovies
        
        return list
    }
}
