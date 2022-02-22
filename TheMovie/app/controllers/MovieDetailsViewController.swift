//
//  MovieDetailsViewController.swift
//  TheMovie
//
//  Created by Monika Mateska on 21.2.22.
//

import UIKit

class MovieDetailsViewController: UIViewController, Storyboarded {
    weak var coordinator: AppCoordinator?
    
    @IBOutlet weak var movieTitle: UILabel!
//    @IBOutlet weak var releaseDate: UILabel!
//    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    private var movieOverview: PopularMovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitle.text = movieOverview?.title
        
        if let posterUrl = movieOverview?.posterUrl {
            ImageCache.publicCache.load(url: posterUrl as NSURL) { [weak self] loadedImage in
                self?.moviePoster.image = loadedImage
            }
        }
    }
    
    func fetchDetails(of movie: PopularMovieModel) {
        movieOverview = movie
    }
}
