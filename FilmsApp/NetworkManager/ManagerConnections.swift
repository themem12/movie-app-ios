//
//  ManagerConnections.swift
//  FilmsApp
//
//  Created by Saavedra, Guillermo on 24/10/23.
//

import Foundation
import RxSwift

class ManagerConnections {
    
    func getPopularMovies() -> Observable<[Movie]> {
        return Observable.create { observer in
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constant.URL.main+Constant.EndPoints.urlPopularMoviesList+Constant.apiKey)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            session.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)
                        observer.onNext(movies.listOfMovies)
                    } catch let error {
                        observer.onError(error)
                    }
                } else if response.statusCode == 401 {
                    print("Error 401")
                }
                observer.onCompleted()
            }.resume()
            
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    func getDetailMovies() {
        
    }
}
