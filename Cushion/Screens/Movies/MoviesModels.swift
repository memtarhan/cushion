//
//  MoviesModels.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 23.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

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
