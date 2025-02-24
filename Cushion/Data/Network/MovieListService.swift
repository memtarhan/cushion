//
//  MovieListService.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 24.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol MovieListService: APIService {
    func getTopRated(atPage page: Int) async throws -> MovieResponse
    func getNowPlaying(atPage page: Int) async throws -> MovieResponse
    func getUpcoming(atPage page: Int) async throws -> MovieResponse
    func getPopular(atPage page: Int) async throws -> MovieResponse
}

struct MovieListServiceImpl: MovieListService {
    func getTopRated(atPage page: Int) async throws -> MovieResponse {
        guard let endpoint = Endpoints.moviesTopRated(page: page).url else {
            throw APIError.badURL
        }

        return try await fetchMovieList(url: endpoint).response
    }

    func getNowPlaying(atPage page: Int) async throws -> MovieResponse {
        guard let endpoint = Endpoints.moviesNowPlaying(page: page).url else {
            throw APIError.badURL
        }

        return try await fetchMovieList(url: endpoint).response
    }

    func getUpcoming(atPage page: Int) async throws -> MovieResponse {
        guard let endpoint = Endpoints.moviesUpcoming(page: page).url else {
            throw APIError.badURL
        }

        return try await fetchMovieList(url: endpoint).response
    }

    func getPopular(atPage page: Int) async throws -> MovieResponse {
        guard let endpoint = Endpoints.moviesPopular(page: page).url else {
            throw APIError.badURL
        }

        return try await fetchMovieList(url: endpoint).response
    }

    private func fetchMovieList(url: URL) async throws -> MovieListResponse {
        let response: MovieListResponse = try await handleDataTask(from: url)
        return response
    }
}
