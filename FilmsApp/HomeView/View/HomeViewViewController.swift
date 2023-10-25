//
//  HomeViewViewController.swift
//  FilmsApp
//
//  Created by Saavedra, Guillermo on 10/10/23.
//

import UIKit
import RxSwift

class HomeViewViewController: UIViewController {
    
    private var router = HomeViewRouter()
    private var viewModel = HomeViewViewModel()
    private var disposeBag = DisposeBag()
    private var moviesList = [Movie]()

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bind(viewController: self, router: router)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
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
}

extension HomeViewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = moviesList[indexPath.row].title
        return cell
    }
}
