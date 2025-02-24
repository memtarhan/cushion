//
//  Enpoints.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 22.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

fileprivate let baseURL = "http://127.0.0.1:8000"

enum Endpoints {
    case seriesTopRated(page: Int)
    case moviesTopRated(page: Int)
    case moviesNowPlaying(page: Int)
    case moviesUpcoming(page: Int)
    case moviesPopular(page: Int)
    case movieDetails(id: String)

    var url: URL? {
        switch self {
        case let .seriesTopRated(page: page):
            return URL(string: "\(baseURL)/tv/popular?page=\(page)")

        case let .moviesTopRated(page: page):
            return URL(string: "\(baseURL)/movies/top_rated?page=\(page)")

        case let .moviesNowPlaying(page: page):
            return URL(string: "\(baseURL)/movies/now_playing?page=\(page)")

        case let .moviesUpcoming(page: page):
            return URL(string: "\(baseURL)/movies/upcoming?page=\(page)")

        case let .moviesPopular(page: page):
            return URL(string: "\(baseURL)/movies/popular?page=\(page)")

        case let .movieDetails(id: id):
            return URL(string: "\(baseURL)/movies/\(id)/details")
        }
    }
}
