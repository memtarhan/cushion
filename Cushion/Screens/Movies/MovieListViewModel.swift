//
//  MovieListViewModel.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 24.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [MovieOverviewModel] = []

    private let service: MovieListService

    private var currentPage = 1

    var listCategory: MovieListCategory?

    // TODO: Add dependency injection
    init() {
        service = MovieListServiceImpl()
    }

    func fetchMovies() {
        guard let listCategory = listCategory else { return }

        Task {
            do {
                let response = try await service.getMovies(forListCategory: listCategory, page: currentPage)
                let newMovies = response.results.map { result in
                    MovieOverviewModel(id: result.id, poster: result.poster, title: result.title)
                }
                movies.append(contentsOf: newMovies)

            } catch {
                print("Error fetching movies: \(error)")
            }
        }
    }
}
