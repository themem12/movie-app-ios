//
//  Constants.swift
//  FilmsApp
//
//  Created by Saavedra, Guillermo on 19/10/23.
//

import UIKit

struct Constant {
    
    static let apiKey = "?api_key=b530344e6b35b9e51dd69f6609edec84"
    
    struct URL {
        static let main = "https://api.themoviedb.org/"
        static let urlImages = "https://image.tmdb.org/t/p/w200"
    }
    
    struct EndPoints {
        static let urlPopularMoviesList = "3/movie/popular"
        static let detailMovie = "3/movie/"
    }
    
    static let moviePlaceHolderImage = UIImage(named: "movie_placeholder")!
}
