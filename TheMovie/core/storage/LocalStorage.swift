//
//  LocalStorage.swift
//  TheMovie
//
//  Created by Monika Mateska on 22.2.22.
//

import Foundation

/// Local storage defining methods for saving / retrieving values.
protocol LocalStorage {
    
    /// Saves the movie as a favourite.
    ///
    /// - Parameters:
    ///   - id, the id of the movie
    func addMovieToFavourites(id: Int)
    
    /// Removes the movie from the favourites list.
    ///
    /// - Parameters:
    ///   - id, the id of the movie
    func removeMovieFromFavourites(id: Int)
    
    /// Retrieves indicator whether the movie is in favourites list.
    ///
    /// - Parameters:
    ///   - id, the id of the movie
    /// - Returns: Bool value for the provided movie id.
    func isMovieInFavourites(id: Int) -> Bool
    
    func clearData()
}
