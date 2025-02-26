//
//  MoviesModels.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 23.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

enum MovieListCategory: String, APIResponse {
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
    case nowPlaying = "Now Playing"

    var title: String {
        rawValue
    }
    
    var sortIndex: Int {
        switch self {
        case .popular:
            return 0
        case .topRated:
            return 1
        case .upcoming:
            return 2
        case .nowPlaying:
            return 3
        }
    }
}

struct MovieCategoryOverviewModel: Identifiable {
    let category: MovieListCategory
    let movies: [MovieOverviewModel]

    var id: String { category.rawValue }
}

struct MovieOverviewModel: Identifiable {
    let id: String
    let poster: String
    let title: String
}

struct MovieDetailsModel {
    let poster: String
    let backdrop: String
    let title: String
    let runtime: String
    let year: String
    let genre: String
    let rated: String
    let imdbRating: String
    let awardsDescription: String
    let overview: String
    let director: String
    let writer: String
    let cast: [MovieCreditModel]
}

struct MovieCreditModel: Identifiable {
    let name: String
    let character: String
    let photo: String

    var id: String { name + character + photo }
}
