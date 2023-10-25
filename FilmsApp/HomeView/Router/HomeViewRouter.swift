//
//  HomeViewRouter.swift
//  FilmsApp
//
//  Created by Saavedra, Guillermo on 10/10/23.
//

//This class create an object HomeViewController and serve as a router to other Views
import UIKit

class HomeViewRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceViewController: UIViewController?
    
    private func createViewController() -> UIViewController {
        let viewController = HomeViewViewController(nibName: "HomeViewViewController", bundle: .main)
        return viewController
    }
    
    func setSourceViewController(sourceView: UIViewController?) {
        guard let view = sourceView else {
            fatalError("Error desconocido")
        }
        self.sourceViewController = view
    }
}
