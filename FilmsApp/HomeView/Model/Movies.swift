//
//  Movies.swift
//  FilmsApp
//
//  Created by Saavedra, Guillermo on 24/10/23.
//

import Foundation

struct Movies: Codable {
    let listOfMovies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case listOfMovies = "results"
    }
}

struct Movie: Codable {
    let title: String
    let originalTitle: String
    let popularity: Double
    let movieId: Int
    let voteCount: Int
    let voteAverage: Double
    let sinopsis: String
    let releaseDate: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case originalTitle = "original_title"
        case popularity
        case movieId = "id"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case sinopsis = "overview"
        case releaseDate = "release_date"
        case image = "poster_path"
    }
}
