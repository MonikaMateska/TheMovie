//
//  ViewController.swift
//  TheMovie
//
//  Created by Monika Mateska on 20.2.22.
//

import UIKit

class PopularMoviesViewController: UIViewController, Storyboarded {
    
    weak var coordinator: AppCoordinator?

    @IBOutlet weak var tableView: UITableView!
    
    private var currentPage = 1
    private let pageLimit = 15
    
    private var movies = [PopularMovieModel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupView()
        fetchData()
    }
    
    private func setupView() {
        self.title = "Popular Movies"
        setTableViewDelegates()
        tableView.rowHeight = 300
    }
    
    private func setTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchData(completionHandler: @escaping(Bool) -> () = { _ in }) {
        Task {
            do {
                let popularMovies = try await APIService.shared.fetchPopularMovies(page: currentPage)
                handleLoadedMovies(popularMovies)
                completionHandler(true)
            } catch {
                handleError(error)
                completionHandler(false)
            }
        }
    }
    
    private func handleLoadedMovies(_ loadedMovies: [PopularMovieModel]) {
        self.movies.append(contentsOf: loadedMovies)
    }
    
    private func handleError(_ error: Error) {
        var message = "Could not load the movies"
        
        if let error = error as? APIError,
           case .cannotReadAPIKey = error {
            message = "Please provide valid API key"
        }
        
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Try Reloading",
                                      style: .default,
                                      handler: { [weak self] _ in
            self?.fetchData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension PopularMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        
        switch listSection {
        case .list:
            if movies.isEmpty {
                tableView.setEmptyView(message: "No movies found")
            } else {
                tableView.restore()
            }
            return movies.count
        case .loader:
            return movies.count >= pageLimit ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularMovieCell") as! PopularMovieTableViewCell

        switch section {
        case .list:
            let movie = movies[indexPath.row]
            cell.setup(with: movie)
        case .loader:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          guard let section = TableSection(rawValue: indexPath.section) else { return }
          guard !movies.isEmpty else { return }

          if section == .loader {
              fetchData { [weak self] success in
                  if !success {
                      self?.hideBottomLoader()
                  }
              }
          }
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        
        coordinator?.movieDetails(of: selectedMovie)
    }
    
      private func hideBottomLoader() {
          DispatchQueue.main.async {
              let lastListIndexPath = IndexPath(row: self.movies.count - 1,
                                                section: TableSection.list.rawValue)
              self.tableView.scrollToRow(at: lastListIndexPath, at: .bottom, animated: true)
          }
      }
    
}
