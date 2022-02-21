//
//  PopularMovieMocks.swift
//  TheMovie
//
//  Created by Monika Mateska on 21.2.22.
//

import Foundation

class PopularMovieMocks {
    
    static let popularMovies = [movie1, movie2, movie3]
    
    static let movie1 = PopularMovieModel(id: 297761, title: "Suicide Squad", posterUrl: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg", overview: "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.")
    
    static let movie2 = PopularMovieModel(id: 324668, title: "Jason Bourne", posterUrl: "/lFSSLTlFozwpaGlO31OoUeirBgQ.jpg", overview: "The most dangerous former operative of the CIA is drawn out of hiding to uncover hidden truths about his past.")
    
    static let movie3 = PopularMovieModel(id: 291805, title: "Now You See Me 2", posterUrl: "/hU0E130tsGdsYa4K9lc3Xrn5Wyt.jpg", overview: "One year after outwitting the FBI and winning the public’s adulation with their mind-bending spectacles, the Four Horsemen resurface only to find themselves face to face with a new enemy who enlists them to pull off their most dangerous heist yet.")
}
