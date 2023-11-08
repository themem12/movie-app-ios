//
//  HomeViewViewController.swift
//  FilmsApp
//
//  Created by Saavedra, Guillermo on 10/10/23.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewViewController: UIViewController {
    
    private var router = HomeViewRouter()
    private var viewModel = HomeViewViewModel()
    private var disposeBag = DisposeBag()
    private var moviesList = [Movie]()
    private var filteredMovies = [Movie]()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barStyle = .black
        searchController.searchBar.backgroundColor = .clear
        searchController.searchBar.placeholder = "Buscar película"
        return searchController
    }()

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bind(viewController: self, router: router)
        
        navigationItem.title = "TheMovieApp"
        
        getData()
        
        configureTableView()
        
        manageSearchBarController()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CustomMovieCell.nib, forCellReuseIdentifier: CustomMovieCell.identifier)
    }
    
    private func getData() {
        viewModel.getListMoviesData()
        // Manejar la concurrencia o hilos de RxSwift
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        // Subscribirse a el observable
            .subscribe { [weak self] moviesList in
                self?.moviesList = moviesList
                self?.reloadTableView()
            } onError: { [weak self] error in
                print("error: ", error.localizedDescription)
                self?.view.backgroundColor = .red
                self?.tableView.backgroundColor = .red
                self?.reloadTableView()
            }.disposed(by: disposeBag)
        // Dar por completado la secuencia de RxSwift
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            self?.tableView.reloadData()
        }
    }
    
    private func manageSearchBarController() {
        let searchBar = searchController.searchBar
        searchController.delegate = self
        tableView.tableHeaderView = searchBar
        tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { result in
                self.filteredMovies = self.moviesList.filter({ movie in
                    movie.title.contains(result)
                })
                self.reloadTableView()
                
            }).disposed(by: disposeBag)
    }
}

extension HomeViewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMovies.count
        } else {
            return moviesList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomMovieCell.identifier, for: indexPath) as? CustomMovieCell else { return UITableViewCell() }
        var movie: Movie
        if searchController.isActive && searchController.searchBar.text != "" {
            movie = filteredMovies[indexPath.row]
        } else {
            movie = moviesList[indexPath.row]
        }
        cell.titleLabel.text = movie.title
        cell.descriptionLabel.text = movie.sinopsis
        cell.imageMovie.imageFromServerURL(urlString: movie.image.createImageUrl(), placeHolderImage: Constant.moviePlaceHolderImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension HomeViewViewController: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTableView()
    }
}
