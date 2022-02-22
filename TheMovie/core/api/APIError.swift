//
//  APIError.swift
//  TheMovie
//
//  Created by Monika Mateska on 21.2.22.
//

import Foundation

enum APIError: Error {
    case invalidUrl
    case decodingError
    case serverEror
    case failed(error: Error)
    case unknownError
    case cannotReadAPIKey
}
