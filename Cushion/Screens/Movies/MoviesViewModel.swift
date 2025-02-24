//
//  MoviesViewModel.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 23.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var nowPlayingMovies: [MovieOverviewModel] = []
    @Published var upcomingMovies: [MovieOverviewModel] = []
    @Published var topRatedMovies: [MovieOverviewModel] = []
    @Published var popularMovies: [MovieOverviewModel] = []

    private let service: MovieListService

    init() {
        service = MovieListServiceImpl()
    }

    func handleData() {
        Task(priority: .background) {
            if let response = try? await service.getMovies(forListCategory: .nowPlaying, page: 1) {
                nowPlayingMovies = response.results.map { result in
                    MovieOverviewModel(id: result.id, poster: result.poster, title: result.title)
                }
            }

            if let response = try? await service.getMovies(forListCategory: .upcoming, page: 1) {
                upcomingMovies = response.results.map { result in
                    MovieOverviewModel(id: result.id, poster: result.poster, title: result.title)
                }
            }

            if let response = try? await service.getMovies(forListCategory: .topRated, page: 1) {
                topRatedMovies = response.results.map { result in
                    MovieOverviewModel(id: result.id, poster: result.poster, title: result.title)
                }
            }

            if let response = try? await service.getMovies(forListCategory: .popular, page: 1) {
                popularMovies = response.results.map { result in
                    MovieOverviewModel(id: result.id, poster: result.poster, title: result.title)
                }
            }
        }
    }
}
