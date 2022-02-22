//
//  PopularMovieTableViewCell.swift
//  TheMovie
//
//  Created by Monika Mateska on 22.2.22.
//

import UIKit

class PopularMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var tableCell: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var favouriteButton: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var localStorage: LocalStorage?
    private var movieId: Int?
    
    var localMovieIsInFavourites: Bool {
        guard let localStorage = localStorage,
              let movieId = movieId else {
            return false
        }
        
        return localStorage.isMovieInFavourites(id: movieId)
    }
    
    func setup(with movie: PopularMovieModel, localStorage: LocalStorage?) {
        self.localStorage = localStorage
        self.movieId = movie.id
        
        movieTitle.text = movie.title
        releaseDate.text = movie.formattedReleaseDate
        overview.text = movie.overview
        
        moviePoster.layer.cornerRadius = 20
        moviePoster.clipsToBounds = true
        moviePoster.layer.masksToBounds = true
        activityIndicator.startAnimating()
        
        if localMovieIsInFavourites {
            favouriteButton.image = UIImage(systemName: "heart.fill")
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favouriteTapped))
        favouriteButton.isUserInteractionEnabled = true
        favouriteButton.addGestureRecognizer(tapGestureRecognizer)
        
        if let posterURL = movie.posterUrl {
            moviePoster.imageFromServer(url: posterURL,
                                        placeHolder: UIImage(named: "placeholder"),
                                        completionHandler: { [weak self] in
                self?.stopActivityIndicator()
            })
        } else {
            stopActivityIndicator()
            moviePoster.image = UIImage(named: "placeholder")
        }
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    @objc func favouriteTapped() {
        guard let localStorage = localStorage,
              let movieId = movieId else {
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
