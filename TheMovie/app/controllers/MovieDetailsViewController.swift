//
//  MovieDetailsViewController.swift
//  TheMovie
//
//  Created by Monika Mateska on 21.2.22.
//

import UIKit

class MovieDetailsViewController: UIViewController, Storyboarded {
    weak var coordinator: AppCoordinator?
    var localStorage: LocalStorage?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var favouriteButton: UIImageView!
    
    private var movieOverview: PopularMovieModel?
    
    var localMovieIsInFavourites: Bool {
        guard let localStorage = localStorage,
              let movieId = movieOverview?.id else {
            return false
        }
        
        return localStorage.isMovieInFavourites(id: movieId)
    }
    
    var titleWithReleaseDate: String {
        guard let movieOverview = movieOverview else {
            return ""
        }
        return "\(movieOverview.title)\n(\(movieOverview.formattedReleaseDate))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight)
        
        movieTitle.text = titleWithReleaseDate
        overview.text = movieOverview?.overview
        
        if localMovieIsInFavourites {
            favouriteButton.image = UIImage(systemName: "heart.fill")
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favouriteTapped))
        favouriteButton.isUserInteractionEnabled = true
        favouriteButton.addGestureRecognizer(tapGestureRecognizer)
        
        if let posterUrl = movieOverview?.posterUrl {
            ImageCache.publicCache.load(url: posterUrl as NSURL) { [weak self] loadedImage in
                self?.moviePoster.image = loadedImage
            }
        }
    }
    
    func fetchDetails(of movie: PopularMovieModel) {
        movieOverview = movie
    }
    
    @objc func favouriteTapped() {
        guard let localStorage = localStorage,
              let movieId = movieOverview?.id else {
            return
        }
        
        if localMovieIsInFavourites {
            localStorage.removeMovieFromFavourites(id: movieId)
            favouriteButton.image = UIImage(systemName: "heart")
        } else {
            localStorage.addMovieToFavourites(id: movieId)
            favouriteButton.image = UIImage(systemName: "heart.fill")
        }
    }
}
