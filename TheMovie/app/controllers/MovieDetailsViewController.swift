//
//  MovieDetailsViewController.swift
//  TheMovie
//
//  Created by Monika Mateska on 21.2.22.
//

import UIKit

class MovieDetailsViewController: UIViewController, Storyboarded {
    weak var coordinator: AppCoordinator?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieTitle: UILabel!
//    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    private var movieOverview: PopularMovieModel?
    
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
