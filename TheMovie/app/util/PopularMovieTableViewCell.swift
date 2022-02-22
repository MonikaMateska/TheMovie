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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func setup(with movie: PopularMovieModel) {
        movieTitle.text = movie.title
        releaseDate.text = movie.formattedReleaseDate
        overview.text = movie.overview
        
        moviePoster.layer.cornerRadius = 20
        moviePoster.clipsToBounds = true
        moviePoster.layer.masksToBounds = true
        activityIndicator.startAnimating()
        
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
    
    
    
}
