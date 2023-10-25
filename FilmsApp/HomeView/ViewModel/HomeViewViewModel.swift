//
//  HomeViewViewModel.swift
//  FilmsApp
//
//  Created by Saavedra, Guillermo on 10/10/23.
//

import Foundation
import RxSwift

class HomeViewViewModel {
    private weak var viewController: HomeViewViewController?
    private var router: HomeViewRouter?
    private var managerConnection = ManagerConnections()
    
    func bind(viewController: HomeViewViewController, router: HomeViewRouter) {
        self.viewController = viewController
        self.router = router
        
        self.router?.setSourceViewController(sourceView: self.viewController)
    }
    
    func getListMoviesData() -> Observable<[Movie]> {
        return managerConnection.getPopularMovies()
    }
}
