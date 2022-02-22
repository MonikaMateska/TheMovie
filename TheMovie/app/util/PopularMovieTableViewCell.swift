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
        releaseDate.text = formatDate(movie.releaseDate)
        overview.text = movie.overview
        
        moviePoster.layer.cornerRadius = 20
        moviePoster.clipsToBounds = true
        moviePoster.layer.masksToBounds = true
        activityIndicator.startAnimating()
        
        if let posterPath = movie.posterPath {
            moviePoster.imageFromServer(imagePath: posterPath,
                                        placeHolder: UIImage(named: "placeholder"),
                                        completionHandler: { [weak self] in
                self?.stopActivityIndicator()
            })
        } else {
            stopActivityIndicator()
            moviePoster.image = UIImage(named: "placeholder")
        }
    }
    
    func formatDate(_ inputDate: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd MMM yyyy"
        
        if let date = inputDateFormatter.date(from: inputDate) {
            return outputDateFormatter.string(from: date)
        } else {
            return inputDate
        }
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    
    
}
