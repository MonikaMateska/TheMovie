//
//  LocalStorageImpl.swift
//  TheMovie
//
//  Created by Monika Mateska on 22.2.22.
//

import Foundation

/// Unsecure storage implemenentation of the local storage.
class UserDefaultsStorage: LocalStorage {
    
    private let favouritesKey = "favouritesKey"
    
    func addMovieToFavourites(id: Int) {
        UserDefaults.standard.set(true, forKey: movieKey(id))
    }
    
    func removeMovieFromFavourites(id: Int) {
        UserDefaults.standard.set(false, forKey: movieKey(id))
    }
    
    func isMovieInFavourites(id: Int) -> Bool {
        return UserDefaults.standard.value(forKey: movieKey(id)) as? Bool ?? false
    }
    
    func clearData() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }
    
    func movieKey(_ id: Int) -> String {
        "\(favouritesKey)-\(id)"
    }
}
