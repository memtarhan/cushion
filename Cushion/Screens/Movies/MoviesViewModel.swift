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

    @Published var movies: [MovieCategoryOverviewModel] = []

    @Published var loading: Bool = false

    private let service: MovieListService

    init() {
        service = MovieListServiceImpl()
    }

    func handleData() {
        loading = true
        Task(priority: .background) {
            async let nowPlayingTask = try? service.getMovies(forListCategory: .nowPlaying, page: 1)
            async let upcomingTask = try? service.getMovies(forListCategory: .upcoming, page: 1)
            async let topRatedTask = try? service.getMovies(forListCategory: .topRated, page: 1)
            async let popularTask = try? service.getMovies(forListCategory: .popular, page: 1)

            let responses = await [nowPlayingTask, upcomingTask, topRatedTask, popularTask]
            movies = responses.map { response in
                let models = response?.results.map { result in
                    MovieOverviewModel(id: result.id, poster: result.poster, title: result.title)
                }.compactMap { $0 }

                if let models,
                   let category = MovieListCategory(rawValue: response?.title ?? "") {
                    return MovieCategoryOverviewModel(category: category, movies: models)

                } else {
                    return nil
                }
            }.compactMap { $0 }
            
            movies.sort { $0.category.sortIndex < $1.category.sortIndex}

            loading = false

//            if let response = try? await service.getMovies(forListCategory: .nowPlaying, page: 1) {
//                nowPlayingMovies = response.results.map { result in
//                    MovieOverviewModel(id: result.id, poster: result.poster, title: result.title)
//                }
//            }
//
//            if let response = try? await service.getMovies(forListCategory: .upcoming, page: 1) {
//                upcomingMovies = response.results.map { result in
//                    MovieOverviewModel(id: result.id, poster: result.poster, title: result.title)
//                }
//            }
//
//            if let response = try? await service.getMovies(forListCategory: .topRated, page: 1) {
//                topRatedMovies = response.results.map { result in
//                    MovieOverviewModel(id: result.id, poster: result.poster, title: result.title)
//                }
//            }
//
//            if let response = try? await service.getMovies(forListCategory: .popular, page: 1) {
//                popularMovies = response.results.map { result in
//                    MovieOverviewModel(id: result.id, poster: result.poster, title: result.title)
//                }
//            }
        }
    }
}
